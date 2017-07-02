#!/bin/bash

# add repos
sudo add-apt-repository -y "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main"
sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

# basic update
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

# install apps
sudo apt-get -y install \
    steam wine \
    filezilla neofetch \
    p7zip p7zip-full p7zip-rar\
    qemu-kvm libvirt-bin bridge-utils virt-manager
    
# install Template
#sudo curl -sS https://getcomposer.org/installer | php
#sudo mv composer.phar /usr/local/bin/composer
#sudo chmod 755 /usr/local/bin/composer

# hBlock Host file update 
# https://github.com/zant95/hBlock

curl 'https://raw.githubusercontent.com/zant95/hblock/master/hblock' -o /tmp/hblock && \
  echo 'dd02198ad592fbd9ac26372b24e7239cc8e3735eb754a3689cb514de3663651c  /tmp/hblock' | shasum -c && \
  sh /tmp/hblock

# Virtualbox
sudo adduser x vboxusers

# fonts
mkdir ~/.fonts
cp -ar ./data/fonts/* ~/.fonts/

# scripts
mkdir ~/.scripts
cp -ar ./data/scripts/* ~/.scripts/
chmod +x ~/.scripts/*

# dotfiles
shopt -s dotglob
cp -a ./data/dotfiles/* ~

# autostart
cp -a ./data/autostart/* ~/.config/autostart/

# Filezilla servers
mkdir ~/.filezilla/
cp -a ./data/filezilla/sitemanager.xml ~/.filezilla/

# Terminal
cp -a ./data/gconf/%gconf.xml ~/.gconf/apps/gnome-terminal/profiles/Default/

# folders
rm -rf ~/Documents
rm -rf ~/Public
rm -rf ~/Templates
rm -rf ~/Videos
rm -rf ~/Music
rm ~/examples.desktop
mkdir ~/Development
mkdir ~/BTSync

# update system settings
gsettings set com.canonical.indicator.power show-percentage true
gsettings set com.canonical.indicator.sound interested-media-players "['spotify.desktop']"
gsettings set com.canonical.indicator.sound preferred-media-players "['spotify.desktop']"
gsettings set com.canonical.Unity form-factor 'Netbook'
gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://sublime-text.desktop', 'application://spotify.desktop', 'application://nautilus.desktop', 'application://gnome-control-center.desktop', 'application://gitg.desktop', 'application://gnome-terminal.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
gsettings set com.canonical.Unity.Lenses remote-content-search 'none'
gsettings set com.canonical.Unity.Runner history "['/home/x/.scripts/screen_colour_correction.sh']"
gsettings set com.ubuntu.update-notifier regular-auto-launch-interval 0
gsettings set de.mh21.indicator.multiload.general autostart true
gsettings set de.mh21.indicator.multiload.general speed 500
gsettings set de.mh21.indicator.multiload.general width 75
gsettings set de.mh21.indicator.multiload.graphs.cpu enabled true
gsettings set de.mh21.indicator.multiload.graphs.disk enabled true
gsettings set de.mh21.indicator.multiload.graphs.load enabled true
gsettings set de.mh21.indicator.multiload.graphs.mem enabled true
gsettings set de.mh21.indicator.multiload.graphs.net enabled true
gsettings set de.mh21.indicator.multiload.graphs.swap enabled false
gsettings set org.freedesktop.ibus.general engines-order "['xkb:us::eng']"
gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng']"
gsettings set org.gnome.DejaDup backend 'file'
gsettings set org.gnome.DejaDup delete-after 365
gsettings set org.gnome.DejaDup include-list "['/home/x/Development', '/home/x/Pictures']"
gsettings set org.gnome.DejaDup periodic-period 1
gsettings set org.gnome.DejaDup welcomed true
gsettings set org.gnome.desktop.a11y.magnifier mag-factor 13.0
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/163_by_e4v.jpg'
gsettings set org.gnome.desktop.default-applications.terminal exec 'gnome-terminal'
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch', 'compose:rctrl']"
gsettings set org.gnome.desktop.media-handling autorun-never true
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false
gsettings set org.gnome.gitg.preferences.commit.message right-margin-at 72
gsettings set org.gnome.gitg.preferences.commit.message show-right-margin true
gsettings set org.gnome.gitg.preferences.diff external false
gsettings set org.gnome.gitg.preferences.hidden sign-tag true
gsettings set org.gnome.gitg.preferences.view.files blame-mode true
gsettings set org.gnome.gitg.preferences.view.history collapse-inactive-lanes 2
gsettings set org.gnome.gitg.preferences.view.history collapse-inactive-lanes-active true
gsettings set org.gnome.gitg.preferences.view.history search-filter false
gsettings set org.gnome.gitg.preferences.view.history show-virtual-staged true
gsettings set org.gnome.gitg.preferences.view.history show-virtual-stash true
gsettings set org.gnome.gitg.preferences.view.history show-virtual-unstaged true
gsettings set org.gnome.gitg.preferences.view.history topo-order false
gsettings set org.gnome.gitg.preferences.view.main layout-vertical 'vertical'
gsettings set org.gnome.nautilus.list-view default-zoom-level 'smaller'
gsettings set org.gnome.nautilus.preferences executable-text-activation 'ask'
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal 'XF86Launch1'
gsettings set org.gnome.settings-daemon.plugins.power critical-battery-action 'shutdown'
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'nothing'

# update some more system settings
dconf write /org/compiz/profiles/unity/plugins/unityshell/icon-size 32
dconf write /org/compiz/profiles/unity/plugins/core/vsize 1
dconf write /org/compiz/profiles/unity/plugins/core/hsize 5
dconf write /org/compiz/profiles/unity/plugins/opengl/texture-filter 2
dconf write /org/compiz/profiles/unity/plugins/unityshell/alt-tab-bias-viewport false

# requires clicks
sudo apt-get install -y ubuntu-restricted-extras

# prompt for a reboot
clear
echo ""
echo "===================="
echo " TIME FOR A REBOOT! "
echo "===================="
echo ""
