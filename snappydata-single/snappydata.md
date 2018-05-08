Example instructions:

```
wget https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.4/EasyRSA-3.0.4.tgz
tar xvf EasyRSA-3.0.4.tgz
cd EasyRSA-3.0.4
./easyrsa init-pki
./easyrsa build-ca
# Type a passphrase snappydata
# Type the node's name
./easyrsa gen-req node.example.com nopass
./easyrsa sign-req server node.example.com nopass
mkdir -p ../snappydata-cert
cp pki/private/node.example.com.key ../snappydata-cert/
cp pki/issued/node.example.com.crt ../snappydata-cert/
cp pki/private/node.example.com ../snappydata-cert/
cp pki/ca.crt ../snappydata-cert/
```

Convert to java jks.

```
openssl pkcs12 -export -inkey snappydata-cert/node.example.com.key -in snappydata-cert/node.example.com.crt -out keystore.jks -password pass:changeit
```

Add to conf for locator, server, and lead

```
node.example.com -thrift-binary-protocol=true -thrift-framed-transport=true -thrift-ssl=true -thrift-ssl-properties=keystore=keystore.jks,keystore-password=changeit,protocol=TLS,enabled-protocols=TLSv1:TLSv1.1:TLSv1.2,cipher-suites=TLS_RSA_WITH_AES_128_CBC_SHA:TLS_RSA_WITH_AES_256_CBC_SHA:TLS_RSA_WITH_AES_128_CBC_SHA256:TLS_RSA_WITH_AES_256_CBC_SHA256
```

Generate keys for machine.

```
ssh-keygen -t rsa -b 4096 -C "node@node.example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
ssh-add -L
echo ssh-rsa ... >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh/authorized_keys
```

Start ssh server.

```
sudo yum install -y openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
```

Start SnappyData server

```
sbin/snappy-start-all.sh
```


Misc
```
./easyrsa revoke client.example
```
