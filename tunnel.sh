ssh -oKexAlgorithms=+diffie-hellman-group1-sha1\
 -oHostKeyAlgorithms=+ssh-rsa\
 -oCiphers=+aes256-cbc\ 
 -oStrictHostKeyChecking=no \
 -R mzltest-3bc5:80:localhost:8888 serveo.net
