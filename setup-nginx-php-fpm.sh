#Sets up default LEMP Stack on Ubuntu (14.04x64) with Nginx, MySql 5.5, PHP-FPM 5.5
#CONFIGURATION
MYSQLPASS="password"
MYSQLDATABASE="wordpress"
SERVERNAMEORIP="example.com"

#update everything
apt-get update
#install php, mysql, nginx
apt-get -y install nginx
#you may need to enter a password for mysql-server
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQLPASS}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQLPASS}"
sudo apt-get -y install mysql-server mysql-client

apt-get install -y php5-mysql php5-fpm php5-gd php5-cli

#configure phpfpm settings
sed -i "s/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini
sed -i "s/^;listen.owner = www-data/listen.owner = www-data/" /etc/php5/fpm/pool.d/www.conf
sed -i "s/^;listen.group = www-data/listen.group = www-data/" /etc/php5/fpm/pool.d/www.conf
sed -i "s/^;listen.mode = 0660/listen.mode = 0660/" /etc/php5/fpm/pool.d/www.conf



#configure nginx
mkdir /usr/share/nginx/cache

sed -i "s/^\tworker_connections 768;/\tworker_connections 1536;/" /etc/nginx/nginx.conf

sed -i "s/^\t#passenger_ruby \/usr\/bin\/ruby;/\t#passenger_ruby \/usr\/bin\/ruby;\n\n\tfastcgi_cache_path \/usr\/share\/nginx\/cache\/fcgi levels=1:2 keys_zone=microcache:10m max_size=1024m inactive=1h;/" /etc/nginx/nginx.conf


sed -i "s/^\tindex index.html index.htm;/\tindex index.php index.html index.htm;/" /etc/nginx/sites-available/default
sed -i "s/^\tserver_name localhost;/\tserver_name $SERVERNAMEORIP;/" /etc/nginx/sites-available/default
sed -i "s/^\tlocation \/ {/\n\tlocation ~ \\\.php$ {\n\t\ttry_files \$uri =404;\n\t\tfastcgi_split_path_info ^(.+\\\.php)(\/.+)\$;\n\t\tfastcgi_pass unix:\/var\/run\/php5-fpm.sock;\n\t\tfastcgi_index index.php;\n\t\tinclude fastcgi_params;\n\t}\n\tlocation \/ {/" /etc/nginx/sites-available/default



#just restarting to make sure they have latest
service nginx restart
service mysql restart
service php5-fpm restart

##create MySql Database
mysql -uroot -p$MYSQLPASS -e "create database ${MYSQLDATABASE}"


cd /usr/share/nginx/html
#get WordPress latest
wget http://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
#move WordPress to web woot
mv /usr/share/nginx/html/wordpress/* /usr/share/nginx/html/

#cleanup folder
rm -rf wordpress

#Done! 
#Go through WordPress install with database and password you setup here
#You may need to create wp-config.php




