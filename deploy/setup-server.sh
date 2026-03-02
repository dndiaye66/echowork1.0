#!/bin/bash
# =============================================================
# EchoWork — Server Setup Script (Ubuntu 22.04)
# Run as root on the server: bash setup-server.sh
# Server IP : 185.98.136.93
# Domain    : www.echowork.net
# =============================================================
set -e

DOMAIN="echowork.net"
WWW_DOMAIN="www.echowork.net"
APP_DIR="/var/www/echowork"
DB_NAME="echowork_db"
DB_USER="echowork"
DB_PASS="$(openssl rand -base64 24)"   # auto-generated, save it!
NODE_VERSION="20"

echo "======================================"
echo " EchoWork — Server Setup"
echo "======================================"

# ── 1. System update ──────────────────────────────────────────
echo "[1/9] Updating system..."
apt-get update -y && apt-get upgrade -y
apt-get install -y curl git unzip ufw certbot python3-certbot-nginx

# ── 2. Node.js ───────────────────────────────────────────────
echo "[2/9] Installing Node.js $NODE_VERSION..."
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
apt-get install -y nodejs
node -v && npm -v

# ── 3. PM2 ───────────────────────────────────────────────────
echo "[3/9] Installing PM2..."
npm install -g pm2
pm2 startup systemd -u root --hp /root

# ── 4. PostgreSQL ─────────────────────────────────────────────
echo "[4/9] Installing PostgreSQL..."
apt-get install -y postgresql postgresql-contrib

systemctl start postgresql
systemctl enable postgresql

# Create DB and user
sudo -u postgres psql <<SQL
CREATE USER ${DB_USER} WITH PASSWORD '${DB_PASS}';
CREATE DATABASE ${DB_NAME} OWNER ${DB_USER};
GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${DB_USER};
SQL

echo ""
echo ">>> PostgreSQL credentials:"
echo "    User    : ${DB_USER}"
echo "    Password: ${DB_PASS}   ← SAVE THIS!"
echo "    Database: ${DB_NAME}"
echo ""

# ── 5. Nginx ─────────────────────────────────────────────────
echo "[5/9] Installing Nginx..."
apt-get install -y nginx
systemctl enable nginx

# ── 6. App directory ─────────────────────────────────────────
echo "[6/9] Creating app directory..."
mkdir -p ${APP_DIR}
mkdir -p /var/www/certbot

# ── 7. Firewall ──────────────────────────────────────────────
echo "[7/9] Configuring firewall..."
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw --force enable

# ── 8. Nginx — temporary HTTP config for Certbot ─────────────
echo "[8/9] Configuring Nginx (HTTP only first, for SSL cert)..."
cat > /etc/nginx/sites-available/echowork <<'NGINX'
server {
    listen 80;
    server_name echowork.net www.echowork.net;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        root /var/www/echowork/dist;
        try_files $uri $uri/ /index.html;
    }
}
NGINX

ln -sf /etc/nginx/sites-available/echowork /etc/nginx/sites-enabled/echowork
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl reload nginx

# ── 9. SSL certificate ───────────────────────────────────────
echo "[9/9] Obtaining SSL certificate..."
certbot --nginx -d ${DOMAIN} -d ${WWW_DOMAIN} --non-interactive --agree-tos -m admin@echowork.net --redirect

echo ""
echo "======================================"
echo " Setup complete!"
echo " Next steps:"
echo "  1. Upload your code to ${APP_DIR}/"
echo "  2. Run deploy.sh"
echo "======================================"
