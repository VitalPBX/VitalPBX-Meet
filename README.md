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
It is always recommended to do an OS update.
<pre>
apt -y update
</pre>

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
Before the next step we must create an extension in VitalPBX and write down the username and password. It is very important that the user format that we are asked for includes the domain, so if for example we create user 2600, the format that we are going to use is 2600@mydomain.com

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

## Enable Jitsi Server Authentication
To configure Jitsi Meet to enable authentication, you must follow the following procedure:
Changes the /etc/prosody/conf.avail/mydomain.cfg.lua file.

<pre>
nano -w /etc/prosody/conf.avail/mydomain.com.cfg.lua
</pre>

Find the line that says ‘VirtualHost mydoamin.com” Underneath that line you’ll see another line that says:
<pre>
authentication = "jitsi_anonymous" 
</pre>

Change that line to:
<pre>
authentication = "internal_plain"  
</pre>

This disables the anonymous authentication for the ‘main’ server host URL – however, we also need to create a new virtual host for our anonymous guests in order to facilitate their anonymous connections. Scroll to the bottom of the file and add these lines to create the new virtual host with the anonymous login method (use your own FQDN):

<pre>
VirtualHost "guest.mydomain.com"
    authentication = "anonymous"
    c2s_require_encryption = false 
</pre>

Next we need to configure our newly created VirtualHost / anonymous domain in our config.js file:
<pre>
nano -w /etc/jitsi/meet/mydomain.com-config.js
</pre>

Under the ‘var config = [‘ section (right near the top of the file), you should already see a line that says domain: ‘mydomain.com’, (it’ll say your FQDN, not mine). Just below that line, after the comment, you should see a line that is commented out that starts with ‘anonymousdomain.’ Uncomment that line and add your FQDN with a ‘guest.’ in front of it like this:
<pre>
anonymousdomain: 'guest.mydomain.com',
</pre>

Next, we need to tell the Jicofo service to only allow requests from our ‘authenticated’ domain.
<pre>
nano -w /etc/jitsi/jicofo/logging.properties
</pre>

Add a new line at the bottom of this file:
<pre>
org.jitsi.jicofo.auth.URL=XMPP:mydomain.com
</pre>

For this type security to work I also must edit jicofo.conf
<pre>
nano -w /etc/jitsi/jicofo/jicofo.conf
</pre>

Add this before the last "}"
<pre>
  authentication: {
    enabled: true
    type: XMPP
    login-url: mydomain.com
  }
</pre>

Now let’s restart our Jitsi services:

<pre>
systemctl restart prosody
systemctl restart jicofo
systemctl restart jitsi-videobridge2
</pre>

To add users who can create video conferences in Jitsi, run the following command:
prosodyctl register <username> jitsi.crosstalksolutions.com <password>
So – to create user ‘john’ with password ‘12345’ you would run:

<pre>
prosodyctl register admin mydomain.com 12345
</pre>

Now after you create a new conference it will ask you for your username and password, which in this case would be:<br>
User: admin<br>
Password: 12345<br>

## Note:
A special thanks to Crosstalk Solution for providing some of the information on how to activate in Jitsi authentication.<br>
https://www.crosstalksolutions.com/how-to-enable-jitsi-server-authentication/
