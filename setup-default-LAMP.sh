#Sets up default LAMP Stack on Ubuntu (14.04x64) with Apache 2.4.7, MySql 5.5, PHP 5.5
#CONFIGURATION
MYSQLPASS=password
MYSQLDATABASE=wordpress

#update everything
apt-get update
#install php, mysql, apache
#you may need to enter a password for mysql-server
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQLPASS}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQLPASS}"
sudo apt-get -y install mysql-server mysql-client


apt-get install -y apache2 php5 php5-mysql
#just restarting to make sure they have latest
service apache2 restart
service mysql restart

##create MySql Database
mysql -uroot -p$MYSQLPASS -e "create database ${MYSQLDATABASE}"


cd /var/www/html
#get WordPress latest
wget http://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
#move WordPress to web woot
mv /var/www/html/wordpress/* /var/www/html/
#cleanup folder
rm -rf wordpress

#Done! 
#Go through WordPress install with database and password you setup here
#You may need to create wp-config.php




