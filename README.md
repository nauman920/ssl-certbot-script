# SSL Certbot Script
🔧 What This Script Does

✅ Checks if Nginx is installed; installs it if missing.

✅ Checks if Certbot is installed; installs it if missing.

🚫 Exits if an Nginx config for the given domain already exists (to prevent overwrites).

🛠 Creates an Nginx reverse proxy configuration pointing to a local app (e.g., Node.js).

🌐 Enables the new site and disables the default Nginx config.

🔄 Tests and reloads Nginx to apply changes.

🔐 Uses Certbot to issue a free SSL certificate for the domain via Let's Encrypt.
