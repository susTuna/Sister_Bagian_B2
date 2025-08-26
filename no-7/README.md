# COBOL Banking Application

A modern banking application that combines COBOL backend processing with FastAPI web services and Kubernetes deployment.

## Architecture Overview

- **Backend**: COBOL program (`main.cob`) for core banking operations
- **API Layer**: FastAPI (Python) for HTTP endpoints and CORS handling  
- **Frontend**: Simple HTML/JavaScript interface for banking operations
- **Deployment**: Kubernetes with persistent storage
- **Infrastructure**: Minikube cluster with reverse proxy and HTTPS

## 1. Rai Stone to IDR Implementation

*Note: The rai stone to IDR conversion logic appears to be implemented in the COBOL backend (`main.cob`). Based on the current account data showing balance of 1690.00, here's the expected implementation pattern:*

```cobol
WORKING-STORAGE SECTION.
01  RAI-STONE-RATE          PIC 9(7)V99 VALUE 1000000.00.
01  WS-RAI-AMOUNT          PIC 9(7)V99.
01  WS-IDR-EQUIVALENT      PIC 9(15)V99.

PROCEDURE DIVISION.
    MULTIPLY WS-RAI-AMOUNT BY RAI-STONE-RATE 
        GIVING WS-IDR-EQUIVALENT.
```

## 2. Kubernetes Deployment

The application is deployed on Kubernetes 1.33 using Minikube with the following components:

### Persistent Volume Claim
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: cobol-data-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

### Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cobol-app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cobol-app
  template:
    metadata:
      labels:
        app: cobol-app
    spec:
      containers:
      - name: cobol-app-container
        image: sustuna/cobol-app:latest
        ports:
        - containerPort: 8000
        volumeMounts:
        - name: cobol-data-storage
          mountPath: /data
      volumes:
      - name: cobol-data-storage
        persistentVolumeClaim:
          claimName: cobol-data-pvc
```

### Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: cobol-app-service
spec:
  type: NodePort
  selector:
    app: cobol-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8000
    nodePort: 31290
```

### Port Forwarding Setup

The `portforwarding.sh` script creates a systemd service for persistent port forwarding from Minikube to the VPS's public IP:

```bash
# Creates systemd service
sudo systemctl enable cobol-app-port-forward.service
sudo systemctl start cobol-app-port-forward.service

# Port forwards to public IP
kubectl port-forward --address 0.0.0.0 service/cobol-app-service 31290:80
```

This makes the service accessible at `http://167.71.212.205:31290`.

## 3. Interest Application

*Note: Interest calculation logic should be implemented in the COBOL backend. Here's the expected pattern:*

```cobol
WORKING-STORAGE SECTION.
01  INTEREST-RATE           PIC 9V999 VALUE 0.025.
01  WS-PRINCIPAL           PIC 9(10)V99.
01  WS-INTEREST            PIC 9(10)V99.
01  WS-NEW-BALANCE         PIC 9(10)V99.

PROCEDURE DIVISION.
    MULTIPLY WS-PRINCIPAL BY INTEREST-RATE 
        GIVING WS-INTEREST.
    ADD WS-PRINCIPAL TO WS-INTEREST 
        GIVING WS-NEW-BALANCE.
```

The interest application would be run as separate service using supervisor configured in `Dockerfile` with specific action codes processed by the COBOL program.

## 4. Reverse Proxy

The application uses an Apache HTTP Server (httpd) reverse proxy setup from the [Tamamo Silang](https://github.com/susTuna/Sister_Bagian_B2/blob/main/no-1/vps-proj/README.md) configuration. A new entry was added for the cobol-app:

```apache
# Example reverse proxy configuration
<VirtualHost *:443>
    ServerName cobol-banking.yourdomain.com
    
    ProxyPreserveHost On
    ProxyPass / http://167.71.212.205:31290/
    ProxyPassReverse / http://167.71.212.205:31290/
    
    # SSL configuration handled by Tamamo Silang
</VirtualHost>
```

This setup allows external access to the banking application through a clean domain name while maintaining security through the reverse proxy layer.

## 5. HTTPS Configuration

HTTPS is configured at the reverse proxy level using the existing [Tamamo Silang](https://github.com/susTuna/Sister_Bagian_B2/blob/main/no-1/vps-proj/README.md) SSL setup. The reverse proxy:

1. **Terminates SSL/TLS**: Handles all HTTPS connections and certificate management
2. **Forwards HTTP**: Sends decrypted traffic to the backend Kubernetes service
3. **Certificate Management**: Uses existing SSL certificate infrastructure from Tamamo Silang

```
Client (HTTPS) → Reverse Proxy (SSL Termination) → Kubernetes Service (HTTP) → COBOL App
```

This architecture provides:
- SSL/TLS encryption for client connections
- Centralized certificate management
- Load balancing capabilities
- Security isolation between public internet and internal services

## Banking Operations

The application supports four main operations:

- **NEW**: Create new account
- **DEP**: Deposit funds
- **WDR**: Withdraw funds  
- **BAL**: Check balance

### Example Usage

```bash
# Check balance for account 123456
curl -X POST http://167.71.212.205:31290/banking \
  -H "Content-Type: application/json" \
  -d '{"account": "123456", "action": "BAL", "amount": 0.0}'
```

Response:
```json
{
  "status": "success",
  "result": "BALANCE:            001690.00"
}
```

## File Structure

```
.
├── main.cob              # COBOL banking logic (missing from provided files)
├── Dockerfile           # Container build configuration (missing)
├── app.py              # FastAPI web service
├── index.html          # Web interface
├── accounts.txt        # Account data storage
├── input.txt           # COBOL program input
├── output.txt          # COBOL program output
├── requirements.txt    # Python dependencies
├── deployment.yaml     # Kubernetes deployment
├── service.yaml        # Kubernetes service
├── pvc.yaml           # Persistent volume claim
└── portforwarding.sh  # Port forwarding helper
```

## Deployment Instructions

1. Build and push Docker image:
```bash
docker build -t your_username/cobol-app:latest .
docker push your_username/cobol-app:latest
```

2. Deploy to Kubernetes:
```bash
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

3. Set up port forwarding:
```bash
chmod +x portforwarding.sh
./portforwarding.sh
```

4. Configure reverse proxy and HTTPS

## Testing

Access the web interface at your configured domain or directly at `http://167.71.212.205:31290` to perform banking operations.