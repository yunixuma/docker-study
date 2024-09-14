FROM debian:bullseye-slim
# FROM debian:bullseye

# Install WordPress dependencies
RUN apt-get update
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-server
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-client
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-common
RUN apt-get install -y -o Debug::pkgProblemResolver=yes tzdata
RUN rm -rf /var/lib/apt/lists/*

# CMD ["which", "cat"]
# CMD ["which", "ls"]
# CMD ["cat", "/etc/os-release"]
# CMD ["ls", "-l", "/var/log/*log"]
# CMD ["ls", "-l", "/var/log/faillog", "/var/log/lastlog"]
# CMD ["ls", "-l", "/var/log/faillog", "/var/log/lastlog"]
# CMD ["tail", "-f", "/var/log/syslog"]
# CMD ["cat", "/var/log/nginx/error.log"]
# CMD ["cat", "/var/log/faillog"]
# CMD ["cat", "/var/log/lastlog"]

# Expose the default MariaDB port
EXPOSE 3306

# Copy the custom MariaDB configuration file (if you have one)
# COPY my.cnf /etc/mysql/my.cnf

# Start MariaDB service
CMD ["mysqld"]
