#!/bin/bash
# 此处为您的脚本
# install packages
sudo apt update
sudo apt install curl wget tomcat9 gnome-session gdm3 fcitx firefox fonts-noto-cjk git gcc make default-jdk -y
#non-interactive for keyboards
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
sudo apt-get install -y -q
# dependency for guacamole
sudo apt install libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin uuid-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libssl-dev libvorbis-dev libwebp-dev -y

#build server

wget https://dlcdn.apache.org/guacamole/1.5.0/source/guacamole-server-1.5.0.tar.gz
tar -xzf guacamole-server-1.5.0.tar.gz
cd guacamole-server-1.5.0/
#sometimes needed --disable-dependency-tracking
./configure --with-init-dir=/etc/init.d --disable-dependency-tracking
make
sudo make install
sudo ldconfig
#rdp server installed later
sudo apt install xrdp -y
#adduser /todo:use vars
sudo adduser mzltest --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "mzltest:mzltest" | sudo chpasswd
sudo usermod -aG sudo mzltest
#mkdir for guacamole
sudo mkdir /etc/guacamole
sudo wget -P /etc/guacamole https://raw.githubusercontent.com/mzltest/gug2/main/user-mapping.xml
#install client
wget https://dlcdn.apache.org/guacamole/1.5.0/binary/guacamole-1.5.0.war
sudo cp guacamole-1.5.0.war /var/lib/tomcat9/webapps/guacamole.war


#pulseaudio-xrdp



sudo apt install build-essential dpkg-dev libpulse-dev git autoconf libtool libudev-dev libdbus-1-dev libspeex-dev libsndfile1-dev pulseaudio -y
cd ~
git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
cd pulseaudio-module-xrdp
bash scripts/install_pulseaudio_sources_apt_wrapper.sh 
./bootstrap && ./configure PULSE_DIR=~/pulseaudio.src 
make
sudo make install


sudo service xrdp start
#sudo service guacd start
sudo service tomcat9 start

sudo ss -ltn
curl -s https://packagecloud.io/install/repositories/immortal/immortal/script.deb.sh | sudo bash
sudo apt install immortal -y
immortal guacd
#tunnel it

#ngrok-install
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | \
      sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
      echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | \
      sudo tee /etc/apt/sources.list.d/ngrok.list && \
      sudo apt update && sudo apt install ngrok


#wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
#chmod +x cloudflared-linux-amd64
#./cloudflared-linux-amd64 tunnel --url http://localhost:8080
