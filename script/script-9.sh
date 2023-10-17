#!/bin/bash
# script ini ada di Arjuna dan 3 workernya
9-Arjuna(){
echo -e '
nameserver 192.168.122.1
nameserver 10.55.1.4 # IP Yudhistira
nameserver 10.55.1.5 # IP Werkudara
' > /etc/resolv.conf

ping google.com -c 3
apt-get update
apt-get install bind9 nginx
apt-get install dnsutils -y
apt-get install lynx -y
}

9-Prabakusuma(){
echo -e '
nameserver 192.168.122.1
nameserver 10.55.1.4 # IP Yudhistira
nameserver 10.55.1.5 # IP Werkudara
' > /etc/resolv.conf
apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y
apt-get install dnsutils -y

mkdir /var/www/praktikum-jarkom

echo '
 <?php
  echo "Halo, Kamu berada di Prabakusuma";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
 server {

 	listen 80;

 	root /var/www/praktikum-jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/arjuna.f07_error.log;
 	access_log /var/log/nginx/arjuna.f07_access.log;
 }
' > /etc/nginx/sites-available/arjuna.f07

ln -s /etc/nginx/sites-available/arjuna.f07 /etc/nginx/sites-enabled
service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
}

9-Abimanyu(){
echo -e '
nameserver 192.168.122.1
nameserver 10.55.1.4 # IP Yudhistira
nameserver 10.55.1.5 # IP Werkudara
' > /etc/resolv.conf
apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y
apt-get install dnsutils -y

mkdir /var/www/praktikum-jarkom

echo '
 <?php
  echo "Halo, Kamu berada di Abimanyu";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
 server {

 	listen 80;

 	root /var/www/praktikum-jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/arjuna.f07_error.log;
 	access_log /var/log/nginx/arjuna.f07_access.log;
 }
' > /etc/nginx/sites-available/arjuna.f07

ln -s /etc/nginx/sites-available/arjuna.f07 /etc/nginx/sites-enabled
service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
}

9-Wisanggeni(){
echo -e '
nameserver 192.168.122.1
nameserver 10.55.1.4 # IP Yudhistira
nameserver 10.55.1.5 # IP Werkudara
' > /etc/resolv.conf
apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y
apt-get install dnsutils -y

mkdir /var/www/praktikum-jarkom

echo '
 <?php
  echo "Halo, Kamu berada di Wisanggeni";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
 server {

 	listen 80;

 	root /var/www/praktikum-jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/arjuna.f07_error.log;
 	access_log /var/log/nginx/arjuna.f07_access.log;
 }
' > /etc/nginx/sites-available/arjuna.f07

ln -s /etc/nginx/sites-available/arjuna.f07 /etc/nginx/sites-enabled
service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
}


9-Arjuna-LB(){
echo '
 upstream myweb  {
 	server 10.55.3.2; #IP Prabakusuma
 	server 10.55.3.3; #IP Abimanyu
 	server 10.55.3.4; #IP Wisanggeni
 }

 server {
 	listen 80;
 	server_name arjuna.f07.com www.arjuna.f07.com;

 	location / {
 	proxy_pass http://myweb;
 	}
 }
' > /etc/nginx/sites-available/lb-arjuna.f07

 ln -s /etc/nginx/sites-available/lb-arjuna.f07 /etc/nginx/sites-enabled
 service nginx restart
}