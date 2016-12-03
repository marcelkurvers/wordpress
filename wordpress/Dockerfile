########################################
#  Wordpress Dockerfile / Installation
########################################

# Set base image
FROM appcontainers/centos

# File Author / Maintainer
MAINTAINER marcelkurvers marcel.kurvers@gmail.com

# Met directories toevoegen bijvoorbeeld
# ADD rpms /tmp, en dan zonder de /

# Pre-reqs / RUN statement in one line to prevent the size getting bigger and bigger
RUN yum clean all && \
yum -y update && \
yum -y install httpd ntpd rsyslog crond mod_rewrite mod_ssl mod_env php php-common php-cli php-mysql mysql-server unzip wget && \
rm -fr /var/cache/*

# Files that need to be added
ADD mysql_setup.sql /tmp/
ADD wordpress.conf /etc/httpd/conf.d/

# Application install
RUN wget -P /var/www/html/ https://wordpress.org/latest.zip && \
unzip /var/www/html/latest.zip -d /var/www/html/ && \
rm -fr /var/www/html/latest.zip

# Run MySQL install
RUN service mysqld start && \
mysql < /tmp/mysql_setup.sql && \
rm -fr /tmp/mysql_setup.sql* && \
service mysqld stop

# Copy the WP-config file
RUN cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

# Edit the wp-config file
# /s = Substitute everything in wp-config sample file with certain name g = global
RUN sed -ie 's/database_name_here/wordpress/g' /var/www/html/wordpress/wp-config.php && \
sed -ie 's/username_here/wpuser/g' /var/www/html/wordpress/wp-config.php && \
sed -ie 's/password_here/PassW0rd/g' /var/www/html/wordpress/wp-config.php

# Set permissions
RUN chown -R apache:apache /var/www/html/wordpress && \
chmod -R 775 /var/www/html/wordpress

# Start Apache and mySQL on boot
RUN echo "service mysqld start" >> ~/.bashrc && \
echo "service httpd start" >> ~/.bashrc && \
echo "service rsyslog start" >> ~/.bashrc
# echo "service ntpd start" >> ~/.bashrc && \
# echo "service crond start" >> ~/.bashrc

# Expose Necessary Ports
EXPOSE 80
