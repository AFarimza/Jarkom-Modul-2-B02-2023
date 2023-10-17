# script ini ada di Arjuna dan 3 workernya
10-Arjuna-LB(){
echo '
 upstream myweb  {
 	server 10.55.3.2:8001; #IP Prabakusuma
 	server 10.55.3.3:8002; #IP Abimanyu
 	server 10.55.3.4:8003; #IP Wisanggeni
 }

 server {
 	listen 80;
 	server_name arjuna.f07.com;

 	location / {
 	proxy_pass http://myweb;
 	}
 }
' > /etc/nginx/sites-available/lb-arjuna.f07
ln -s /etc/nginx/sites-available/lb-arjuna.f07 /etc/nginx/sites-enabled
service nginx restart
}

10-Prabakusuma(){
echo '
 <?php
  echo "Halo, Kamu berada di Prabakusuma";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
server {

 	listen 8001;

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

nginx_port=$(awk '/listen/ {print $2}' /etc/nginx/sites-available/arjuna.f07)
echo "
 <?php
  echo ',tepatnya di port : $nginx_port'
 ?>
" >> /var/www/praktikum-jarkom/index.php

service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
}

10-Abimanyu(){
echo '
 <?php
  echo "Halo, Kamu berada di Abimanyu";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
server {

 	listen 8002;

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

nginx_port=$(awk '/listen/ {print $2}' /etc/nginx/sites-available/arjuna.f07)
echo "
 <?php
  echo ',tepatnya di port : $nginx_port'
 ?>
" >> /var/www/praktikum-jarkom/index.php

service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
}

10-Wisanggeni(){
echo '
 <?php
  echo "Halo, Kamu berada di Wisanggeni";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
server {

 	listen 8003;

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

nginx_port=$(awk '/listen/ {print $2}' /etc/nginx/sites-available/arjuna.f07)
echo "
 <?php
  echo ',tepatnya di port : $nginx_port'
 ?>
" >> /var/www/praktikum-jarkom/index.php

service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
}