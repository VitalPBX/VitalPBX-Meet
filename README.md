# VitalPBX-Meet
VitalPBX Meet - Secure and high quality meetings - Powered by Jitsi Meet<br>

# Introduction
VitalPBX Meet is based on Jitsi Meet which is an Open Source Video Conference solution that allows users to hold online meetings. It's developed by the Jitsi project and enables users to conduct video conferences without the need to download an application, as it operates directly from a web browser.<br>

# Prerequisites
1.-Hardware Minimum Requirements<br>
  •	4GB RAM<br>
  •	2.5GHz CPU<br>
  •	50GB Disk<br>
  •	1GB Net<br><br>
2.- Software Requirements<br>
•	Ubuntu 20.4 recommended<br>
•	OpenJDK 11 must be used<br>
•	A Valid FQDN Domain (Before starting the installation process, remember that you must have your NS server pointing the domain or sub-domain to the IP of the server where we are going to install VitalPBX Meet)<br>

# Installation
Next we are going to download the script to carry out the installation automatically.
<pre>
wget https://raw.githubusercontent.com/VitalPBX/VitalPBX-Meet/main/vpbxmeet.sh
chmod +x vpbxmeet.sh
./vpbxmeet.sh
</pre>

# Interconnect Jitsi with VitalPBX
## How it works
Jigasi registers as a SIP client and can be called or be used by Jitsi Meet to make outgoing calls. Jigasi is NOT a SIP server. It is just a connector that allows SIP servers and B2BUAs to connect to Jitsi Meet. It handles the XMPP signaling, ICE, DTLS/SRTP termination and multiple-SSRC handling for them.

## Create an Extension in VitalPBX
Before the next step we must create an extension in VitalPBx and write down the username and password. It is very important that the user format that we are asked for includes the domain, so if for example we create user 2600, the format that we are going to use is 2600@mydomain.com

## Outgoing calls
To call someone from Jitsi Meet application, Jigasi must be configured and started like described in the 'Install and run' section. This will cause the telephone icon to appear in the toolbar which will popup a call dialog on click.

First we create a PJSIP extension in VitalPBX, and then we proceed to the installation and configuration of the jigasi module.
<pre>
apt install jigasi -y  
</pre>

Finally, we wait for the installation process to finish and proceed to restart the service.
<pre>
systemctl restart jigasi.service
systemctl restart jitsi-videobridge2
</pre>

