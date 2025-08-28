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
77 RAI-TO-IDR-RATE       PIC 9(9) VALUE 120000000.
77 IDR-BALANCE           PIC 9(15).
77 IDR-AMOUNT            PIC 9(15).
77 IDR-FORMATTED         PIC Z(14)9.
77 INPUT-IDR-FLAG        PIC X VALUE "N".

PROCEDURE DIVISION.
APPLY-ACTION.
  EVALUATE IN-ACTION
    WHEN "BAL"
      COMPUTE IDR-BALANCE = TMP-BALANCE * RAI-TO-IDR-RATE
      MOVE IDR-BALANCE TO IDR-FORMATTED
      MOVE SPACES TO OUT-RECORD
      STRING "BALANCE: IDR " DELIMITED BY SIZE
            IDR-FORMATTED DELIMITED BY SIZE
            INTO OUT-RECORD
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
77 INT-RATE         PIC 9V9(5) VALUE 0.00025.
77 INT-AMOUNT       PIC 9(6)V99.
77 INTEREST-COUNTER      PIC 9(6) VALUE 0.

PROCEDURE DIVISION.
MAIN.
  IF ARG-VALUE = "--apply-interest"
    MOVE "Y" TO APPLY-INTEREST
    PERFORM APPLY-INTEREST-TO-ALL
APPLY-INTEREST-TO-ALL.
  OPEN INPUT ACC-FILE
  READ ACC-FILE
    AT END
      CLOSE ACC-FILE
      OPEN OUTPUT OUT-FILE
      MOVE "NO ACCOUNTS FOUND" TO OUT-RECORD
      WRITE OUT-RECORD
      CLOSE OUT-FILE
      EXIT PARAGRAPH
  END-READ
  CLOSE ACC-FILE
  
  MOVE "N" TO UPDATED
  
  OPEN INPUT ACC-FILE
  OPEN OUTPUT TMP-FILE
  
  PERFORM UNTIL 1 = 2
    READ ACC-FILE
      AT END
        EXIT PERFORM
      NOT AT END
        MOVE ACC-RECORD(1:6) TO ACC-ACCOUNT
        MOVE ACC-RECORD(7:3) TO ACC-ACTION  
        MOVE FUNCTION NUMVAL(ACC-RECORD(10:8))
          TO ACC-BALANCE
            
        COMPUTE INT-AMOUNT = ACC-BALANCE * INT-RATE
        
        MOVE ACC-BALANCE TO TEMP-BALANCE
        ADD INT-AMOUNT TO TEMP-BALANCE
        
        IF TEMP-BALANCE > MAX-BALANCE
          MOVE MAX-BALANCE TO ACC-BALANCE
        ELSE
          ADD INT-AMOUNT TO ACC-BALANCE
        END-IF
        
        MOVE ACC-ACCOUNT TO TMP-RECORD(1:6)
        MOVE ACC-ACTION TO TMP-RECORD(7:3)
        MOVE ACC-BALANCE TO FORMATTED-AMOUNT
        MOVE FORMATTED-AMOUNT(2:8) TO TMP-RECORD(10:8)
        
        WRITE TMP-RECORD
        MOVE "Y" TO UPDATED
  END-PERFORM
  
  CLOSE ACC-FILE
  CLOSE TMP-FILE
  
  OPEN OUTPUT OUT-FILE
  IF UPDATED = "Y"
    MOVE "INTEREST APPLIED TO ALL ACCOUNTS" TO OUT-RECORD
  ELSE
    MOVE "NO ACCOUNTS PROCESSED" TO OUT-RECORD
  END-IF
  WRITE OUT-RECORD
  CLOSE OUT-FILE
  
  IF UPDATED = "Y"
    CALL "SYSTEM" USING "mv temp.txt accounts.txt"
  END-IF.
```

The interest application would be run as separate service using supervisor configured in `Dockerfile` with specific action codes processed by the COBOL program.

## 4. Reverse Proxy

The application uses an Apache HTTP Server (httpd) reverse proxy setup from the [Tamamo Silang](https://github.com/susTuna/Sister_Bagian_B2/blob/main/no-1/vps-proj/README.md) configuration. A new entry was added for the cobol-app:

```d
# Example reverse proxy configuration
server {
    listen 443 ssl;
    server_name cobol.domain.name;

    ssl_certificate /etc/letsencrypt/live/cobol.domain.name/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/cobol.domain.name/privkey.pem;

    location / {
        proxy_pass http://kubernetesip:port/
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
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

Access the web interface at your configured domain or directly at `https://tunadev.dokidokispot.com/` to perform banking operations.