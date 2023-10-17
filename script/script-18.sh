# Node Abimanyu

echo -e '<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.f07
  ServerName rjp.baratayuda.abimanyu.f07.com
  ServerAlias www.rjp.baratayuda.abimanyu.f07.com

  <Directory /var/www/rjp.baratayuda.abimanyu.f07>
          AuthType Basic
          AuthName "Restricted Content"
          AuthUserFile /etc/apache2/.htsecure
          Require valid-user
  </Directory>

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.f07.com.conf

htpasswd -c -b /etc/apache2/.htsecure Wayang baratayudaf07

a2ensite rjp.baratayuda.abimanyu.f07.com.conf

service apache2 restart

# Test
# lynx rjp.baratayuda.abimanyu.f07.com:14000
# lynx rjp.baratayuda.abimanyu.f07.com:14400