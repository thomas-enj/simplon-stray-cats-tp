#!/bin/bash
set -e

echo "--> Creating prometheus user..."
useradd --no-create-home --shell /bin/false prometheus 2>/dev/null || true

echo "--> Creating directories..."
mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus

echo "--> Downloading Prometheus..."
PROM_VERSION="2.53.0"
cd /tmp
wget -q https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz
tar xzf prometheus-${PROM_VERSION}.linux-amd64.tar.gz

echo "--> Installing binaries..."
cp prometheus-${PROM_VERSION}.linux-amd64/prometheus /usr/local/bin/
cp prometheus-${PROM_VERSION}.linux-amd64/promtool /usr/local/bin/

echo "--> Creating default configuration..."
cat <<EOF >/etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]
EOF

echo "--> Setting permissions..."
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus /usr/local/bin/prometheus /usr/local/bin/promtool

echo "--> Creating systemd service..."
cat <<EOF >/etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "--> Reloading systemd and starting service..."
systemctl daemon-reload
systemctl enable --now prometheus

echo "--> Prometheus installed successfully!"
