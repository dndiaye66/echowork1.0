#!/bin/bash
# =============================================================
# EchoWork — Deployment Script
# Run on the server: bash deploy.sh
# Assumes code is already uploaded to /var/www/echowork/
# =============================================================
set -e

APP_DIR="/var/www/echowork"
BACKEND_DIR="${APP_DIR}/backend"
NGINX_CONF="/etc/nginx/sites-available/echowork"

echo "======================================"
echo " EchoWork — Deploying..."
echo "======================================"

# ── Backend ──────────────────────────────────────────────────
echo "[1/5] Installing backend dependencies..."
cd ${BACKEND_DIR}
npm install --omit=dev

echo "[2/5] Running Prisma migrations..."
npx prisma migrate deploy
# Uncomment below to re-seed (only on first deploy):
# npx prisma db seed

echo "[3/5] Building backend..."
npm run build

echo "[4/5] (Re)starting backend with PM2..."
if pm2 list | grep -q "echowork-api"; then
    pm2 reload echowork-api
else
    pm2 start ${APP_DIR}/deploy/ecosystem.config.js
fi
pm2 save

# ── Nginx (production config) ─────────────────────────────────
echo "[5/5] Updating Nginx config..."
cp ${APP_DIR}/deploy/nginx-echowork.conf ${NGINX_CONF}
nginx -t && systemctl reload nginx

echo ""
echo "======================================"
echo " Deployment complete!"
echo " Backend : pm2 logs echowork-api"
echo " Site    : https://www.echowork.net"
echo "======================================"
