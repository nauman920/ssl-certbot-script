# SSL Certbot Script
<<<<<<< Updated upstream


## This script:

Installs Nginx and Certbot if needed

Sets up reverse proxy

Removes defaults nginx file

Enables HTTPS with Let’s Encrypt

Protects from overwriting existing domain configs
=======
🔧 What This Script Does
✅ Checks if Nginx is installed; installs it if missing.

✅ Checks if Certbot is installed; installs it if missing.

🚫 Exits if an Nginx config for the given domain already exists (to prevent overwrites).

🛠 Creates an Nginx reverse proxy configuration pointing to a local app (e.g., Node.js).

🌐 Enables the new site and disables the default Nginx config.

🔄 Tests and reloads Nginx to apply changes.

🔐 Uses Certbot to issue a free SSL certificate for the domain via Let's Encrypt.

🔄 Runs a dry run of auto-renewal to confirm Certbot is set up properly.


>>>>>>> Stashed changes
