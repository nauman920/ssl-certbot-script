# SSL Certbot Script
🔧 What This Script Does

✅ Checks if Nginx is installed; installs it if missing.

✅ Checks if Certbot is installed; installs it if missing.

🚫 Exits if an Nginx config for the given domain already exists (to prevent overwrites).

🛠 Creates an Nginx reverse proxy configuration pointing to a local app (e.g., Node.js).

🌐 Enables the new site and disables the default Nginx config.

🔄 Tests and reloads Nginx to apply changes.

🔐 Uses Certbot to issue a free SSL certificate for the domain via Let's Encrypt.


#### 🚀 How to Use This Script

1. **Edit the Script Configuration**
   
   At the top of the script, set your domain name and the port your app is running on:
   ```bash
   DOMAIN="yourdomain.com"
   PORT="3000"

2. Make the Script Executable by Giving Permission 
	"chmod +x ssl-certbot.sh"

3. Run the Script 
	"./ssl-certbot.sh"

⚠️ Make sure your domain (e.g., via Route53 or any DNS provider) is already pointing to your EC2 instance IP before running this script.
