#!/bin/bash
# This code is the property of VitalPBX LLC Company
# License: Proprietary
# Date: 24-Oct-2023
# VitalPBX Meet
#
set -e
echo -e "\n"
echo -e "************************************************************"
echo -e "*        Welcome to the VitalPBX Meet installation         *"
echo -e "*                 Powered by Jitsi Meet                    *"
echo -e "************************************************************"
echo -e "*             Update & Install firewall                    *"
sudo apt -y update
sudo apt -y install ufw
echo -e "*            Downloading Jitsi's public GPG key            *"
curl -fsSL https://download.jitsi.org/jitsi-key.gpg.key -o /etc/apt/keyrings/jitsi-key.gpg.key
echo -e "*            Adding Jitsi's official repository            *"
echo "deb [signed-by=/etc/apt/keyrings/jitsi-key.gpg.key] https://download.jitsi.org stable/" | tee /etc/apt/sources.list.d/jitsi.list
echo -e "*                  We update the system                    *"
apt update
echo -e "*                    Firewall Settings                     *"
sudo ufw allow in ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 4443/tcp
sudo ufw allow 10000:20000/udp
sudo ufw allow 3478/udp
sudo ufw allow 5349/tcp
sudo ufw enable
echo -e "*     We proceed with the installation of JitSi Meet       *"
apt -y install jitsi-meet

echo -e "*     We download the images to use in the Branding        *"
wget https://raw.githubusercontent.com/VitalPBX/VitalPBX-Meet/main/images/watermark.svg -O /usr/share/jitsi-meet/images/watermark.svg
wget https://raw.githubusercontent.com/VitalPBX/VitalPBX-Meet/main/images/logo-vitalpbx.png -O /usr/share/jitsi-meet/images/logo-vitalpbx.png
wget https://raw.githubusercontent.com/VitalPBX/VitalPBX-Meet/main/images/forum-vitalpbx.png -O /usr/share/jitsi-meet/images/forum-vitalpbx.png
wget https://raw.githubusercontent.com/VitalPBX/VitalPBX-Meet/main/images/wiki-vitalpbx.png -O /usr/share/jitsi-meet/images/wiki-vitalpbx.png
wget https://raw.githubusercontent.com/VitalPBX/VitalPBX-Meet/main/images/welcome-background.png -O /usr/share/jitsi-meet/images/welcome-background.png
wget https://raw.githubusercontent.com/VitalPBX/VitalPBX-Meet/main/images/favicon.ico -O /usr/share/jitsi-meet/images/favicon.ico
wget https://raw.githubusercontent.com/VitalPBX/VitalPBX-Meet/main/images/favicon.ico -O /usr/share/jitsi-meet/favicon.ico

echo -e "*         Change configuration file - App name             *"
sed -i 's|Jitsi Meet|VitalPBX Meet|g' /usr/share/jitsi-meet/interface_config.js
echo -e "*                   Change Watermark URL                   *"
sed -i 's|JITSI_WATERMARK_LINK: ‘https://jitsi.org’|JITSI_WATERMARK_LINK: ‘https://vitalpbx.com’|g' /usr/share/jitsi-meet/interface_config.js
echo -e "*                      Change Titles                       *"
sed -i 's|Jitsi Meet|VitalPBX Meet|g' /usr/share/jitsi-meet/title.html

echo -e "*  Change the main title of the page that says Jitsi Meet  *"
sed -i 's|"headerTitle":"Jitsi Meet"|"headerTitle":"VitalPBX Meet"|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
echo -e "*    Change it to another language, for example Spanish    *"
sed -i 's|"headerTitle": "Jitsi Meet"|"headerTitle": "VitalPBX Meet"|g' /usr/share/jitsi-meet/lang/main-es.json

echo -e "*      Change the three logos and URL of the footer        *"
sed -i 's|https://itunes.apple.com/us/app/jitsi-meet/id1165103905|https://vitalpbx.com|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|app-store-badge.png|logo-vitalpbx.png|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|Download mobile app for iOS|VitalPBX WEB Site|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|https://play.google.com/store/apps/details?id=org.jitsi.meet|https://forums.vitalpbx.org|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|google-play-badge.png|forum-vitalpbx.png|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|Download mobile app for Android|VitalPBX Forum|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|https://f-droid.org/en/packages/org.jitsi.meet/|https://wiki.vitalpbx.com|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|f-droid-badge.png|wiki-vitalpbx.png|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|Download mobile app for F-Droid|VitalPBX Wiki|g' /usr/share/jitsi-meet/libs/app.bundle.min.js

echo -e "*    Change the text that says: “Jitsi on mobile....       *"
sed -i 's|Jitsi on mobile|VitalPBX Meet|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|download our apps and start a meeting from anywhere|Powered by Jitsi Meet|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
echo -e "************************************************************"
echo -e "*        VitalPBX Meet has been completely installed       *"
echo -e "*                 Powered by Jitsi Meet                    *"
echo -e "************************************************************"
