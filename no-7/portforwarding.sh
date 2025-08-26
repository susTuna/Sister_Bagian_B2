#!/bin/bash

# Create a systemd service for persistent port forwarding

sudo tee /etc/systemd/system/cobol-app-port-forward.service << 'EOF'
[Unit]
Description=Cobol App Port Forward
After=network.target
Wants=network.target

[Service]
Type=simple
Restart=always
RestartSec=5
User=sustuna
Group=sustuna
WorkingDirectory=/home/sustuna
Environment=HOME=/home/sustuna
ExecStart=/usr/bin/kubectl port-forward --address 0.0.0.0 service/cobol-app-service 31290:80
ExecStop=/bin/kill -TERM $MAINPID

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and enable the service
sudo systemctl daemon-reload
sudo systemctl enable cobol-app-port-forward.service
sudo systemctl start cobol-app-port-forward.service

# Check status
sudo systemctl status cobol-app-port-forward.service

echo "Persistent port forward service created and started"
echo "Your service should be accessible at http://167.71.212.205:31290"