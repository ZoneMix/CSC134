#!/usr/bin/zsh

# Check perms
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root or with sudo"
        exit 1
fi

export DEBIAN_FRONTEND=noninteractive
# Update and upgrade system
apt -qq install ntp -y
systemctl restart ntp.service

apt -qq update -y 
apt -qq update -y --fix-missing
apt -qq upgrade -y 

# Install and run docker
apt install -y docker.io
apt install -y docker-compose
systemctl enable docker
systemctl start docker

if [[ -z $SUDO_USER ]]; then
        echo "Script not ran with sudo. You may need to add your user to docker group manually"
else
        usermod -aG docker $SUDO_USER
fi

# Pulling a few containers
docker pull tleemcjr/metasploitable2 >/dev/null 2>&1
docker pull raesene/bwapp >/dev/null 2>&1
docker pull bkimminich/juice-shop >/dev/null 2>&1
docker pull byt3bl33d3r/crackmapexec >/dev/null 2>&1

# Adding aliases
alias -g msf-run='docker run -it tleemcjr/metasploitable2:latest sh -c "/bin/services.sh && bash"'
alias -g juice-run='docker run --rm -p 3000:3000 bkimminich/juice-shop'
alias -g bwapp-run='docker run -d -p 8081:80 raesene/bwapp'

# Adding SDR packages
sudo zsh -c "$(wget -O - https://raw.githubusercontent.com/DSUmjham/GenCyber/master/SDR/sdr_setup.sh)"

# Install sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update -y 
apt install -y sublime-text

# Install atom
wget -O /tmp/atom-amd64.deb https://github.com/atom/atom/releases/download/v1.49.0/atom-amd64.deb
dpkg -i /tmp/atom-amd64.deb
rm -f /tmp/atom-amd64.deb

# Fix some dependencies
apt --fix-broken install

# Install terminator
apt install -y terminator

# Install ffuf
apt install -y ffuf

# Install jq 
apt install -y jq

# Install autossh
apt install -y autossh

# Install responder
git clone https://github.com/lgandx/Responder.git /opt/responder

# Install enum4linux-ng
git clone https://github.com/cddmp/enum4linux-ng.git /opt/enum4linux-ng

# Install GDB GEF 
wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

# Installing pip (python3 only)
sudo apt install -y python3-pip

# Installing python pwntools
pip install -y pwntools

# Install openvmtools
apt install -y open-vm-tools-desktop

# Install Bettercap
apt install -y libnetfilter-queue-dev libpcap-dev libusb-1.0-0-dev
apt install -y bettercap 

# Install impacket
git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket
pip3 install -r /opt/impacket/requirements.txt
python3 ./setup.py install

#Install Ghidra
apt update --fix-missing -y -qq
apt install -y openjdk-11-jdk
apt install -y ghidra

# Install car hacking tools
# Install Dependencies
apt install -y libsdl2-dev libsdl2-image-dev

# Install canutils
apt install -y can-utils

# Install ICSim
git clone https://github.com/zombieCraig/ICSim.git /opt/ICSim
zsh /opt/ICSim/setup_vcan.sh
make

# Install scantool of obd2
apt install -y scantool


# Canopy install
git clone https://github.com/Tbruno25/canopy /opt/canopy
cd /opt/canopy
pip3 install -r requirements.txt
cd ~

# Check if we're sudo or root
if [[ -z $SUDO_USER ]]; then
  cf_home="~"
  cf_user="root"
else
  cf_home=$(getent passwd $SUDO_USER | cut -d: -f6)
  cf_user=$SUDO_USER
fi
cf_path=$cf_home"/course_files"

# Fix ssh on VM
mkdir -p $cf_home/.ssh/
echo "Host *" > $cf_home/.ssh/config
echo "  IPQoS lowdelay throughput" >> $cf_home/.ssh/config

# Set a few terminator preferences 
install -D /dev/null $cf_home/.config/terminator/config
printf "[global_config]\n  inactive_color_offset = 1.0\n[keybindings]\n[profiles]\n  [[default]]\n    cursor_color = \"#aaaaaa\"\n    foreground_color = \"#ffffff\"\n    scrollback_lines = 4000\n[layouts]\n  [[default]]\n    [[[child1]]]\n      parent = window0\n      type = Terminal\n    [[[window0]]]\n      parent = \"\"\n      type = Window\n[plugins]" > $cf_home/.config/terminator/config

# Unzip rockyou
gunzip /usr/share/wordlists/rockyou.txt.gz

# Set vi line numbers
echo "set number" >> /etc/vim/vimrc

# Run ff
firefox
# Disable firefox captive portal detect and password history - set homepage
# This only works if firefox has already ran
ff_profiles=$(grep "Path" $cf_home/.mozilla/firefox/profiles.ini | cut -d "=" -f2)
for ff_profile in $ff_profiles; do
    echo "user_pref(\"network.captive-portal-service.enabled\", false);" >> "$cf_home/.mozilla/firefox/$ff_profile/user.js"
    echo "user_pref(\"signon.rememberSignons\", false);" >> "$cf_home/.mozilla/firefox/$ff_profile/user.js"
    echo "user_pref(\"browser.startup.homepage\", \"localhost:8000\");" >> "$cf_home/.mozilla/firefox/$ff_profile/user.js"
done

# Clean up
apt autoremove -y 
apt autoclean -y 
rm -f ~/.zsh_history

# Done
chown -hR kali:kali $cf_home/.config
reboot
