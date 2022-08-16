sudo install tomcat9 -y
sudo service tomcat9 start
sudo ps -e
sudo ss -lntp
sudo ufw allow from any to any port 8080 proto tcp
sudo ps -e
sudo ss -lntp
