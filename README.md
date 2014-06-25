WordPressVPS
============

This is an attempt at creating a high performance WordPress VPS brought to you by [Review Signal][1], the honest and transparent web hosting review site. Look up what hundreds of thousands of people think of their web hosting company in our [database][2].

Version 1 is focused around serving static content quickly. 
----------

In future versions I would like to focus on:

- Improving PHP Performance
- Improving MySql/Database Performance
- Other Caching Improvements (Plugins, Memcached, etc)

> **Blitz.io testing results:**
>"This rush generated 28,924 successful hits in 60 seconds and we transferred 218.86 MB of data in and out of your app. The average hit rate of 482/second translates to about 41,650,560 hits/day."
>![WordPress VPS Performance](http://kevinohashi.com/wordpressvps_performance.PNG)

All testing was done on a $10/month Plan from [Digital Ocean][3] with 1GB Ram, 1 Core, 30GB SSD running Ubuntu 14.04x64.


----------


Installation
---------

Every configuration tested has its own **.sh** file. It lists the bash commands to install and configure the particular setup.

**Current Configurations:**
- LAMP (Linux, Apache, MySql, PHP)
- LAMP w/ PHP-FPM (FastCGI Process Manager)
- Nginx w/ PHP-FPM [aka LEMP (Linux, (e)Nginx, MySql, PHP)]
- -Nginx w/ PHP-FPM and Microcaching

> **Note!**
> Make sure you edit MYSQLPASS, MYSQLDATABASE (and SERVERNAMEORIP on nginx configs) variables for your server setup or replace them in the commands where you see the variables, eg. \$MYSQLPASS or \${MYSQLPASS}

There are also comments in the configuration files that explain what things are doing. You may want to change some of them. There also may be links to other resources to help understand or further customize your setup.

>**Warning**
> The .sh files don't run that well and the *sudo debconf-set-selections* commands seem really finnicky. If you run everything line by line, it seems to setup fine, but executing the whole thing as a bash script had some issues.

Finally, this doesn't fully install WordPress, you may need to create the wp-config.php when you go through the install process from the web. The WordPress installer should walk you through everything pretty easily.


  [1]: http://reviewsignal.com/webhosting
  [2]: http://reviewsignal.com/webhosting/compare
  [3]: http://clicks.reviewsignal.com/out.php?c=101&t=wordpressvps-readme