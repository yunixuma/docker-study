-- TRUNCATE TABLE user;
-- FLUSH PRIVILEGES;
-- GRANT ALL PRIVILEGES ON *.* TO root@localhost IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
-- FLUSH PRIVILEGES;
-- QUIT;

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
-- ALTER USER 'root'@'$WP_DB_HOST' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
-- SET PASSWORD = $MYSQL_ROOT_PASSWORD;
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$WP_DB_USER' IDENTIFIED BY '$WP_DB_PASSWORD';
CREATE USER '$WP_DB_USER'@'localhost' IDENTIFIED BY '$WP_DB_PASSWORD';
CREATE USER '$WP_DB_USER'@'$WP_DB_HOST' IDENTIFIED BY '$WP_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'$WP_DB_HOST';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';
-- QUIT;
