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
echo -e "*                 Powered by jtsi Meet                     *"
echo -e "************************************************************"
echo -e "*            Downloading Jitsi's public GPG key            *"
curl -fsSL https://download.jitsi.org/jitsi-key.gpg.key -o /etc/apt/keyrings/jitsi-key.gpg.key
echo -e "*            Adding Jitsi's official repository            *"
echo "deb [signed-by=/etc/apt/keyrings/jitsi-key.gpg.key] https://download.jitsi.org stable/" | tee /etc/apt/sources.list.d/jitsi.list
echo -e "*                  We update the system                    *"
apt update
echo -e "*     We proceed with the installation of JitSi Meet       *"
apt -y install jitsi-meet
echo -e "*     We download the images to use in the Branding        *"
wget https://raw.githubusercontent.com/VitalPBX/vitalpbx_ha_v4/main/welcome



sed -i 's|"headerTitle":"Jitsi Meet"|"headerTitle":"VitalPBX Meet"|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|"headerTitle": "Jitsi Meet"| "headerTitle": "VitalPBX Meet"|g' /usr/share/jitsi-meet/lang/main-es.json
sed -i 's|https://itunes.apple.com/us/app/jitsi-meet/id1165103905|https://vitalpbx.com|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|app-store-badge.png|logo-vitalpbx.png|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|https://play.google.com/store/apps/details?id=org.jitsi.meet|https://forums.vitalpbx.org|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|google-play-badge.png|forum-vitalpbx.png|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|https://f-droid.org/en/packages/org.jitsi.meet/|https://wiki.vitalpbx.com|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
sed -i 's|f-droid-badge.png|wiki-vitalpbx.png|g' /usr/share/jitsi-meet/libs/app.bundle.min.js
