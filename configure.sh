# install packages
sudo apt update

echo "mzltest
mzltest" |sudo adduser "mzltest"
sudo apt install icewm xrdp firefox fonts-noto-cjk 
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64
./cloudflared-linux-amd64 tunnel --url rdp://127.0.0.1:3389
