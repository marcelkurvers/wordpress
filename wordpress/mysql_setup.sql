SET PASSWORD FOR 'root'@'localhost' = PASSWORD('PassW0rd');

CREATE DATABASE wordpress;

GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost' IDENTIFIED BY 'PassW0rd';

DROP DATABASE test;
