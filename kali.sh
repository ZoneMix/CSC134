#!/usr/bin/zsh

# Check perms
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root or with sudo"
        exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# Update and upgrade system
apt -qq update -y 
apt -qq update -y --fix-missing
apt -qq upgrade -y 

# Install and run docker
apt install -y docker.io
apt install -y docker-compose
systemctl enable docker
systemctl start docker

# Add user to docker group
usermod -aG docker $SUDO_USER

# Pulling a few containers
docker pull tleemcjr/metasploitable2 >/dev/null 2>&1
docker pull raesene/bwapp >/dev/null 2>&1
docker pull bkimminich/juice-shop >/dev/null 2>&1

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

# Install Bettercap
apt install -y libnetfilter-queue-dev libpcap-dev libusb-1.0-0-dev
apt install -y bettercap 

#Install Ghidra
apt install -y ghidra

# Install scantool of obd2
apt install -y scantool

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
timedatectl set-timezone US/Central
reboot
