#!/bin/bash
# 此处为您的脚本
# install packages
sudo apt update
sudo apt install wget tomcat9 icewm firefox fonts-noto-cjk git gcc make -y
#non-interactive for keyboards
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
sudo apt-get install -y -q
# dependency for guacamole
sudo apt install libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin uuid-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libssl-dev libvorbis-dev libwebp-dev -y

#build server

wget https://dlcdn.apache.org/guacamole/1.4.0/source/guacamole-server-1.4.0.tar.gz
tar -xzf guacamole-server-1.4.0.tar.gz
cd guacamole-server-1.4.0/
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
#mkdir for guacamole
sudo mkdir /etc/guacamole
sudo wget -P /etc/guacamole https://raw.githubusercontent.com/mzltest/gug2/main/user-mapping.xml
#install client
wget https://dlcdn.apache.org/guacamole/1.4.0/binary/guacamole-1.4.0.war
sudo cp guacamole-1.4.0.war /var/lib/tomcat9/webapps/guacamole.war


#pulseaudio-xrdp


#tunnel it
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64
guacd
./cloudflared-linux-amd64 tunnel --url http://127.0.0.1:8080
