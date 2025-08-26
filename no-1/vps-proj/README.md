Honestly agak males ngeformat readme (gamau buang token jg) jd simple aja

# Setting Up NGINX
## Setup Directory
```bash
mkdir -p vps-proj
mkdir -p vps-proj/data
mkdir -p vps-proj/data/nginx
mkdir -p vps-proj/data/certbot
mkdir -p vps-proj/data/certbot/www
mkdir -p vps-proj/data/certbot/conf
```
## Change directory
```bash
cd vps-proj
```
## Setup NGINX Conf
```bash
touch data/nginx/conf.d
```
## Edit conf.d
```d
server {
    listen 80;
    server_name your_domain_name;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}
```
## Run NGINX
```bash
docker run -d \
  --name nginx_proxy \
  -p 80:80 \
  -p 443:443 \
  -v $(pwd)/data/nginx:/etc/nginx/conf.d \
  -v $(pwd)/data/certbot/conf:/etc/letsencrypt \
  -v $(pwd)/data/certbot/www:/var/www/certbot \
  --restart always \
  nginx:latest
```
## Get Cert
```bash
docker run --rm \
  -v $(pwd)/data/certbot/conf:/etc/letsencrypt \
  -v $(pwd)/data/certbot/www:/var/www/certbot \
  certbot/certbot certonly --webroot --webroot-path /var/www/certbot \
    --email your_email \
    -d your_domain_name \
    --agree-tos \
    --no-eff-email \
    --force-renewal
```
## Update conf.d
```d
server {
    listen 80;
    server_name your_domain_name;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}
#add these lines
server {
    listen 443 ssl;
    server_name your_domain_name;

    ssl_certificate /etc/letsencrypt/live/your_domain_name/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your_domain_name/privkey.pem;

    location / {
        proxy_pass http://ip:port; #replace this with your HTTP server ip and port
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
## Restart NGINX
```bash
docker restart nginx_proxy
```

Done