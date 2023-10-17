# Node Abimanyu
echo -e '<VirtualHost *:80>
    ServerAdmin webmaster@abimanyu.f07.com
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    Redirect / http://www.abimanyu.f07.com/
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

apache2ctl configtest

service apache2 restart

# Test
# lynx 10.55.3.3