# Node Abimanyu
echo -e '
nameserver 10.55.1.4 # IP Yudhistira
nameserver 10.55.1.5 # IP Werkudara
nameserver 192.168.122.1 # IP Router
' > /etc/resolv.conf

apt-get update
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
service apache2 start
apt-get install wget -y
apt-get install unzip -y
apt-get install php -y

wget -O '/var/www/abimanyu.f07.com' 'https://drive.usercontent.google.com/download?id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc'
unzip -o /var/www/abimanyu.f07.com -d /var/www/
mv /var/www/abimanyu.yyy.com /var/www/abimanyu.f07
rm /var/www/abimanyu.f07.com
rm -rf /var/www/abimanyu.yyy.com

cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.f07.com.conf

rm /etc/apache2/sites-available/000-default.conf

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.f07

  ServerName abimanyu.f07.com
  ServerAlias www.abimanyu.f07.com

  <Directory /var/www/abimanyu.f07/index.php/home>
          Options +Indexes
  </Directory>

  Alias "/home" "/var/www/abimanyu.f07/index.php/home"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.f07.com.conf

a2ensite abimanyu.f07.com.conf

service apache2 restart

# Node Client
# apt-get update (Pastikan nameserver router sudah ada)
# apt-get install lynx -y
# lynx abimanyu.f07.com (Run command no 11)
# lynx abimanyu.f07.com/home (Run command no 12)
