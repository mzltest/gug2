# install packages
sudo apt update
sudo apt install wget tomcat9 icewm firefox fonts-noto-cjk git gcc make libsndfile1-dev

# dependency for guacamole
sudo apt install libcairo2-dev libjpeg62-turbo-dev libpng-dev libtool-bin uuid-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libssl-dev libvorbis-dev libwebp-dev

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
sudo apt install xrdp
#adduser /todo:use vars
echo "mzltest
mzltest" |sudo adduser "mzltest"
#mkdir for guacamole
sudo mkdir /etc/guacamole
sudo wget -P /etc/guacamole https://raw.githubusercontent.com/mzltest/gug/main/user-mapping.xml

#install client
wget https://dlcdn.apache.org/guacamole/1.4.0/binary/guacamole-1.4.0.war
sudo cp guacamole-1.4.0.war /var/lib/tomcat9/webapps/guacamole.war 
sudo systemctl restart tomcat9
sudo /etc/init.d/guacd start
#pulseaudio-xrdp
#tunnel it
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64
./cloudflared-linux-amd64 tunnel --url http://127.0.0.1:8080
