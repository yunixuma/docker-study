# docker-study

## Requirements for Inception
### Environment
- Docker containers run on the one VM
### File
- `Makefile` for setting up dockers must be located at the root directory
- configuration files must be placed in srcs folder
- env vars are stored in `.env` file
- git ignore `.env` file
### Command
- Use `docker compose`
- `Makefile` calls `docker-compose.yml`
### Container
- Require 3 services: nginx, wordpress, mariadb
- Don't pull Docker images from DockerHub, need to build yourself
- `latest` tag is prohibited
- The name of each Docker image is same as the service
- nginx container contain nginx, TLSv1.2 or TLSv1.3
- wordpress container contain WordPress + php-fpm without nginx
- mariadb container contain MariaDB without nginx
### Volume
- Require 2 volumes
- The wordpress container uses one volume for the WordPress website files
- The mariadb container uses another volume for the WordPress database
- Volumes located in `/home/{login}/data` of the host filesystem
### Network
- `docker-network` for between containers
- Using network: host or --link or links: is forbidden.
- The network line must be present in `docker-compose.yml` file.
- MariaDB uses port 3306
- The connection between nginx and WordPress + php-fpm uses port 9000
- nginx listens port 443 only
- A client access the WordPress website via port 443 using TLSv1.2 or TLSv1.3
- The domain name for the WordPress website must be `{login}.42.fr`
### Service
- 2 Users are available in the WordPress website
- one of the users is an administrator but the username can't contain `admin`
### Restriction
- Running a script with an infinite loop is forbidden (`tail -f`, bash, sleep infinity, `while true`)
- When crashing, containers have to restart
- Any credentials, API keys private env vars mustn't be in the git repository
