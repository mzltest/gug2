ssh -o KexAlgorithms=+diffie-hellman-group1-sha1 -o HostKeyAlgorithms=+ssh-rsa -o Ciphers=+aes256-cbc -o StrictHostKeyChecking=no -R mzltest-2ba7:80:localhost:8080 serveo.net
