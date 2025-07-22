#!/bin/bash

# ======================
# 🔧 Configuration
# ======================
DOMAIN="example.com"     # <-- Set your domain here
PORT="3000"                 # <-- Set your app's port here

NGINX_CONF="/etc/nginx/sites-available/$DOMAIN"
DEFAULT_SITE="/etc/nginx/sites-enabled/default"

# ======================
# ⚙️ Function Definitions
# ======================

# Check if Nginx is installed
is_nginx_installed() {
    if command -v nginx >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Check if Certbot is installed
is_certbot_installed() {
    if command -v certbot >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# ======================
# 📦 Install Nginx if needed
# ======================

echo "🔍 Checking if Nginx is installed..."
if is_nginx_installed; then
    echo "✅ Nginx is already installed."
else
    echo "❌ Nginx is not installed. Installing..."
    sudo apt update
    sudo apt install -y nginx
    if is_nginx_installed; then
        echo "✅ Nginx successfully installed."
    else
        echo "❌ Nginx installation failed. Exiting."
        exit 1
    fi
fi

# ======================
# 📦 Install Certbot if needed
# ======================

echo "🔍 Checking if Certbot is installed..."
if is_certbot_installed; then
    echo "✅ Certbot is already installed."
else
    echo "❌ Certbot not found. Installing..."
    sudo apt install -y certbot python3-certbot-nginx
    if is_certbot_installed; then
        echo "✅ Certbot successfully installed."
    else
        echo "❌ Certbot installation failed. Exiting."
        exit 1
    fi
fi

# ======================
# 🚫 Check if config already exists
# ======================

if [ -f "$NGINX_CONF" ]; then
    echo "❌ Error: Nginx config for domain '$DOMAIN' already exists at $NGINX_CONF"
    exit 1
fi

# ======================
# ⚙️ Create Nginx Config
# ======================

echo "🛠 Creating Nginx reverse proxy config for $DOMAIN on port $PORT..."
sudo bash -c "cat > $NGINX_CONF" <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://localhost:$PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Enable the site
if [ ! -f "/etc/nginx/sites-enabled/$DOMAIN" ]; then
    sudo ln -s "$NGINX_CONF" /etc/nginx/sites-enabled/
fi

# Remove default site if it exists
if [ -f "$DEFAULT_SITE" ]; then
    echo "🧹 Removing default Nginx site config..."
    sudo rm -f "$DEFAULT_SITE"
fi

# Test Nginx config and reload
echo "🔄 Testing and reloading Nginx..."
sudo nginx -t && sudo systemctl reload nginx

# ======================
# 🔐 Obtain SSL with Certbot
# ======================

echo "🔐 Requesting SSL certificate for $DOMAIN..."
sudo certbot --nginx -d "$DOMAIN"

# Optional: test auto-renewal
echo "🔄 Testing automatic renewal..."
sudo certbot renew --dry-run

echo "✅ SSL setup complete for https://$DOMAIN"
