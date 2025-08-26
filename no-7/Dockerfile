FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    gnucobol \
    libcob4 \
    cron \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY ./* ./
RUN pip install --no-cache-dir -r requirements.txt

RUN cobc -x -o main main.cob

RUN echo '#!/bin/bash\n\
while true; do\n\
    sleep 23\n\
    cd /workspace && ./main --auto-interest >> /var/log/interest.log 2>&1\n\
    echo "$(date): Interest applied" >> /var/log/interest.log\n\
done' > /usr/local/bin/interest-scheduler.sh

RUN chmod +x /usr/local/bin/interest-scheduler.sh

RUN echo '[supervisord]\n\
nodaemon=true\n\
logfile=/var/log/supervisord.log\n\
pidfile=/var/run/supervisord.pid\n\
\n\
[program:uvicorn]\n\
command=uvicorn app:app --host 0.0.0.0 --port 8000\n\
directory=/workspace\n\
autostart=true\n\
autorestart=true\n\
stdout_logfile=/var/log/uvicorn.log\n\
stderr_logfile=/var/log/uvicorn.log\n\
\n\
[program:interest-scheduler]\n\
command=/usr/local/bin/interest-scheduler.sh\n\
autostart=true\n\
autorestart=true\n\
stdout_logfile=/var/log/interest.log\n\
stderr_logfile=/var/log/interest.log' > /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/log

EXPOSE 8000

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]