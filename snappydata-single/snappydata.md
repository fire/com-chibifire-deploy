Example instructions:

Ensure hostname is set.

```
curl -O -L https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.4/EasyRSA-3.0.4.tgz
tar xvf EasyRSA-3.0.4.tgz
cd EasyRSA-3.0.4
./easyrsa init-pki
./easyrsa build-ca
# Type a passphrase snappydata
# change hostname 
# hostnamectl set-hostname snappydata.chibifire.local 
# Type the node's name
./easyrsa gen-req snappydata.chibifire.local nopass
./easyrsa sign-req server snappydata.chibifire.local nopass
./easyrsa gen-req fire-win.chibifire.local nopass
./easyrsa sign-req client fire-win.chibifire.local nopass
mkdir -p ../snappydata-cert
cp pki/private/snappydata.chibifire.local.key ../snappydata-cert/
cp pki/issued/snappydata.chibifire.local.crt ../snappydata-cert/
cp pki/private/fire-win.chibifire.local.key ../snappydata-cert/
cp pki/issued/fire-win.chibifire.local.crt ../snappydata-cert/
cp pki/ca.crt ../snappydata-cert/
```

Convert to java jks.

```
cd ..
openssl pkcs12 -export -inkey snappydata-cert/snappydata.chibifire.local.key -in snappydata-cert/snappydata.chibifire.local.crt -out keystore-snappydata.jks -password pass:changeit
openssl pkcs12 -export -inkey snappydata-cert/fire-win.chibifire.local.key -in snappydata-cert/fire-win.chibifire.local.crt -out keystore-fire-win.jks -password pass:changeit
```

Download Snappydata.

```
curl -O -L https://github.com/SnappyDataInc/snappydata/releases/download/v1.0.1/snappydata-1.0.1-bin.tar.gz
tar xf snappydata-1.0.1-bin.tar.gz
```

Add to conf for locator, server, and lead

```
echo "snappydata.chibifire.local -J-Djava.net.preferIPv4Stack=true \
-heap-size=4096m  -thrift-binary-protocol=true \
  -thrift-framed-transport=true -thrift-ssl=true \
  -thrift-ssl-properties=trusttore=/home/fedora/keystore-snappydata.jks,truststore-password=changeit,protocol=TLS,enabled-protocols=TLSv1:TLSv1.1:TLSv1.2,cipher-suites=TLS_RSA_WITH_AES_128_CBC_SHA:TLS_RSA_WITH_AES_256_CBC_SHA:TLS_RSA_WITH_AES_128_CBC_SHA256:TLS_RSA_WITH_AES_256_CBC_SHA256" \
  | tee -a ./snappydata-1.0.1-bin/conf/servers 

echo "snappydata.chibifire.local \
  -J-Djava.net.preferIPv4Stack=true \
  -heap-size=1024m -thrift-binary-protocol=true -thrift-framed-transport=true \
  -thrift-ssl=true \
  -thrift-ssl-properties=truststore=/home/fedora/keystore-snappydata.jks,truststore-password=changeit,protocol=TLS,enabled-protocols=TLSv1:TLSv1.1:TLSv1.2,cipher-suites=TLS_RSA_WITH_AES_128_CBC_SHA:TLS_RSA_WITH_AES_256_CBC_SHA:TLS_RSA_WITH_AES_128_CBC_SHA256:TLS_RSA_WITH_AES_256_CBC_SHA256" \
 | tee -a ./snappydata-1.0.1-bin/conf/locators
  
echo "snappydata.chibifire.local -J-Djava.net.preferIPv4Stack=true \
-heap-size=4096m \
-thrift-binary-protocol=true -thrift-framed-transport=true -thrift-ssl=true -thrift-ssl-properties=truststore=/home/fedora/keystore-snappydata.jks,truststore-password=changeit,protocol=TLS,enabled-protocols=TLSv1:TLSv1.1:TLSv1.2,cipher-suites=TLS_RSA_WITH_AES_128_CBC_SHA:TLS_RSA_WITH_AES_256_CBC_SHA:TLS_RSA_WITH_AES_128_CBC_SHA256:TLS_RSA_WITH_AES_256_CBC_SHA256" | tee -a ./snappydata-1.0.1-bin/conf/leads
```

Generate keys for machine.

```
ssh-keygen -t rsa -b 4096 -C "node@snappydata.chibifire.local"
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

Open firewall.

```
sudo firewall-cmd --zone=public --add-port=1528/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5050/tcp --permanent
sudo firewall-cmd --reload
```

Install openjdk

```
sudo yum install -y java-1.8.0-openjdk
```

Start SnappyData server

```
sbin/snappy-start-all.sh
```


Misc
```
./easyrsa revoke client.example
```
