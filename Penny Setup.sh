#!/bin/bash -e

# ------------------------------------------------------------
# Setup Environment
# ------------------------------------------------------------
#LIST_OF_APPS="a b c d e"
#$LIST_OF_APPS #Veriable In Use
#PATH=/usr/bin:/bin

echo "============================================"
echo "Rashberry Pi Torrent Box Install Script"
echo "============================================"
echo "run install? (y/n)"
read -e run
if [ "$run" == n ] ; then
exit
else
echo "Please Enter the following variables."
read -e Password

# Enable sources, add PPAs and update sources: 
sudo sed 's/# deb/deb/' -i /etc/apt/sources.list

#sudo add-apt-repository ppa:tiheum/equinox

sudo apt-get update
sudo apt-get upgrade

#Create Directory for mounting
sudo mkdir /media/DataBank

# Adding software:
sudo apt-get install -y vlc

# Create user and grant sudo password.
sudo useradd middlepepper -m -G users
sudo passwd middlepepper

# grabs the ids for the user account created
#middlepeppers id = 1001

id -g middlepepper
id -u middlepepper

# Add auto mount to boot
sudo nano /etc/fstab

#/dev/sda1 /media/DataBank auto nofail,uid=1001,gid=1001,noatime 0 0

=========Samba Server
# install the samba package
sudo apt-get install samba samba-common-bin

# Back up default Conf
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.old

#Add the following
sudo nano /etc/samba/smb.conf
#[NAS] #[NAS]:  This is the name of the share (What you will see in file #explorer)
#comment = NAS Folder #Comment: This is a comment for the associated for share.
#path = /media/DataBank #Path: Path to the folder you wish to share.
#valid users = @users #Valid User: A list of users that are allowed to login to this #share.
#force group = users #Force Group: This specifies a UNIX group name that will be assigned for all users connecting to this share.
#create mask = 0660 
#directory mask = 0771  #Directory Mask: This creates a permission mask for all #directories created on the drive.
#read only = no #Read Only: This allows you to set the share to be read only.

=========Restart Samba=========
#Restart Samba to apply changes.
sudo /etc/init.d/samba restart

#Connect user to samba
sudo smbpasswd -a middlepepper
=========

=====Transmission=====
sudo apt-get install transmission-daemon
# Install Transmission
sudo mkdir -p /media/DataBank/torrent-inprogress
sudo mkdir -p /media/DataBank/torrent-complete
# Create Folders
sudo nano /etc/transmission-daemon/settings.json
# Edit Settings
"incomplete-dir": "/media/DataBank/torrent-inprogress",
"incomplete-dir-enabled": true,
"download-dir": "/media/DataBank/torrent_complete",
"rpc-username": "middlepepper",
"rpc-password": "Your_Password",
"rpc-whitelist": "192.168.*.*",
sudo service transmission-daemon reload
# Restart tranmission
sudo nano /etc/init.d/transmission-daemon
# Change user
USER=middlepepper

sudo chown -R middlepepper:middlepepper /etc/transmission-daemon
sudo chown -R middlepepper:middlepepper /etc/init.d/transmission-daemon
sudo chown -R middlepepper:middlepepper /var/lib/transmission-daemon
# Grant access to new user account

sudo nano /etc/systemd/system/multi-user.target.wants/transmission-daemon.service
sudo systemctl daemon-reload
sudo mkdir -p /home/middlepepper/.config/transmission-daemon/
sudo ln -s /etc/transmission-daemon/settings.json /home/middlepepper/.config/transmission-daemon/
sudo chown -R middlepepper:middlepepper /home/middlepepper/.config/transmission-daemon/
sudo service transmission-daemon start

====================
Setup RSS Feed for Transmission
====================
pip install transmissionrpc
pip install feedparser
wget https://raw.githubusercontent.com/lupus78/feedtransmission/master/feedtransmission.py
feedtransmission.py http://url.to/torrent/feed.xml http://another.url/to/feed
echo "========================="
echo "Installation is complete."
echo "========================="
fi
