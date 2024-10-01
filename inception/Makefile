NAME			:= Inception
export SV		:= nginx
export APP		:= wordpress
export DB		:= mariadb
export DATADIR	:= $(HOME)/data
export DOMAIN	:= 42.fr
export ENVFILE	:= ../.env
SRCDIR			:= ./srcs
YAML			:= -f $(SRCDIR)/docker-compose.yml
FIX_PJ			:= incep
FIX_IMG			:= $(FIX_PJ)-img
FIX_CTNR		:= $(FIX_PJ)-ctnr
FIX_VOL			:= $(FIX_PJ)-vol
CERT_DIR		:= $(SRCDIR)/nginx/ssl
KEY_PATH		:= $(CERT_DIR)/server.key
CSR_PATH		:= $(CERT_DIR)/server.csr
CERT_PATH		:= $(CERT_DIR)/server.crt
export NW		:= $(FIX_PJ)-nw
export IMG_SV	:= $(FIX_IMG)_$(SV)
export IMG_APP	:= $(FIX_IMG)_$(APP)
export IMG_DB	:= $(FIX_IMG)_$(DB)
export CTNR_SV	:= $(FIX_CTNR)_$(SV)
export CTNR_APP	:= $(FIX_CTNR)_$(APP)
export CTNR_DB	:= $(FIX_CTNR)_$(DB)
export VOL_APP	:= $(FIX_VOL)_$(APP)
export VOL_DB	:= $(FIX_VOL)_$(DB)
include .env
export MYSQL_ROOT_PASSWORD
export WP_DB_HOST	:= $(DB).$(USER).$(DOMAIN)
export WP_DB_NAME
export WP_DB_USER
export WP_DB_PASSWORD
export WP_HOME		:= $(APP).$(USER).$(DOMAIN)
export WP_TITLE
export WP_ADMIN_USER
export WP_ADMIN_PASSWORD
export WP_ADMIN_EMAIL
export WP_SUB_USER
export WP_SUB_PASSWORD
export WP_SUB_EMAIL
export IP_SUBNET	:= 172.30.0.0/24
export IP_SV		:= 172.30.0.2
export IP_APP		:= 172.30.0.3
export IP_DB		:= 172.30.0.4

all: up clean
up: cert vol
	docker compose $(YAML) up -d --build
up-sv:
	docker compose $(YAML) up $(SV) -d --build
up-app:
	docker compose $(YAML) up $(APP) -d --build
up-db:
	docker compose $(YAML) up $(DB) -d --build
vol:
	-mkdir -p $(DATADIR)
	-mkdir -p $(DATADIR)/$(APP)
	-mkdir -p $(DATADIR)/$(DB)
del_vol:
	-sudo rm -rf $(DATADIR)/$(DB)
	-rm -rf $(DATADIR)
$(CERT_DIR):
	-mkdir -p $(CERT_DIR)
cert: $(CERT_DIR) cert_exists
ifeq ("$(wildcard $(KEY_PATH))", "")
	openssl genrsa -out $(KEY_PATH) 2048
	openssl req \
		-new \
		-newkey rsa:2048 \
		-days 365 \
		-nodes \
		-x509 \
		-subj "/C=FR/ST=Paris/L=boulevard Bessières/O=$(NAME)/CN=$(WP_HOME)" \
		-keyout $(KEY_PATH) \
		-out $(CERT_PATH)
	# openssl x509 -req -days 365 -in $(CSR_PATH) -signkey $(KEY_PATH) -out $(CERT_PATH)
endif
del_cert:
	-rm $(KEY_PATH) $(CSR_PATH) $(CERT_PATH)
	-rmdir $(CERT_DIR)
build: vol cert
	-docker image rm --force $(IMG_SV) $(IMG_APP) $(IMG_DB)
	docker compose $(YAML) build --no-cache
start:
	docker compose $(YAML) start
ls:
	docker image ls
	docker container ls
	docker volume ls
	docker network ls
	docker compose $(YAML) ls
	docker compose $(YAML) ps
	docker ps
config:
	docker compose $(YAML) config
login-sv:
	docker exec -it $(CTNR_SV) /bin/sh
login-app:
	docker exec -it $(CTNR_APP) /bin/sh
login-db:
	docker exec -it $(CTNR_DB) /bin/sh
info:
	-docker compose $(YAML) top
	-docker compose $(YAML) inspect
	-docker compose $(YAML) events
	-docker compose $(YAML) port
	-docker compose $(YAML) ps
	-docker compose $(YAML) stats
	-docker compose $(YAML) images
	-docker compose $(YAML) services
	-docker compose $(YAML) networks
	-docker compose $(YAML) volumes
	-docker compose $(YAML) exec $(CTNR_SV) nginx -v
	-docker compose $(YAML) exec $(CTNR_APP) wordpress -v
	-docker compose $(YAML) exec $(CTNR_DB) mariadb -v
	-docker compose $(YAML) exec $(CTNR_SV) nginx -V
	-docker compose $(YAML) exec $(CTNR_APP) wordpress -V
	-docker compose $(YAML) exec $(CTNR_DB) mariadb -V
	-docker compose $(YAML) exec $(CTNR_SV) nginx -t
	-docker compose $(YAML) exec $(CTNR_APP) wordpress -t
	-docker compose $(YAML) exec $(CTNR_DB) mariadb -t
	-docker compose $(YAML) exec $(CTNR_SV) nginx -T
	-docker compose $(YAML) exec $(CTNR_APP) wordpress -T
	-docker compose $(YAML) exec $(CTNR_DB) mariadb -T
info-db:
	-docker exec -it $(CTNR_DB) mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e "SELECT user, host FROM mysql.user;"
	-docker exec -it $(CTNR_DB) mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e "SELECT user,host FROM mysql.user;" | awk -F'|' 'NR>2 {print $$2 "@" $$3}' | tr -d " " | grep -v "^$$" | xargs -Iname docker exec -i $(CTNR_DB) mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e "SHOW CREATE USER name;"
	-docker exec -it $(CTNR_DB) mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e "SELECT user,host FROM mysql.user;" | awk -F'|' 'NR>2 {print $$2 "@" $$3}' | tr -d " " | grep -v "^$$" | xargs -Iname docker exec -i $(CTNR_DB) mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e "SHOW GRANTS FOR name;"
	-docker exec -it $(CTNR_DB) mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e "SHOW databases;"
	-docker exec -it $(CTNR_DB) mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e "SHOW databases;" | awk -F '|' 'NR>2 {print $$2}' | tr -d " |" | grep -v "^$$" | head -n 1 | xargs -Iname docker exec -i $(CTNR_DB) mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e "SHOW tables FROM name;"
log:
	docker compose $(YAML) logs --tail 50 --follow --timestamps
log-sv:
	docker inspect --format='{{.LogPath}}' $(CTNR_SV) | sudo xargs tail -f
	# docker logs --tail 50 --follow --timestamps $(CTNR_SV)
log-app:
	docker inspect --format='{{.LogPath}}' $(CTNR_APP) | sudo xargs tail -f
	# docker logs --tail 50 --follow --timestamps $(CTNR_APP)
log-db:
	docker inspect --format='{{.LogPath}}' $(CTNR_DB) | sudo xargs tail -f
	# docker logs --tail 50 --follow --timestamps $(CTNR_DB)
stop:
	docker-compose $(YAML) stop
restart:
	docker-compose $(YAML) restart
down: stop
	docker-compose $(YAML) down -v
clean:
	-docker image ls | grep '<none>' | awk -F' ' '{print $$3}' | xargs --no-run-if-empty docker rmi --force
fclean: del_cert
	-docker compose $(YAML) down --rmi all --volumes --remove-orphans
	# -docker compose $(YAML) down -v
	-docker network rm $(NW)
	# -docker container rm --force $(CTNR_SV) $(CTNR_APP) $(CTNR_DB)
	# -docker image rm --force $(IMG_SV) $(IMG_APP) $(IMG_DB)
	$(MAKE) del_vol
purge: fclean
	-docker container ls | awk -F' ' 'NR>1 {print $$1}' | xargs --no-run-if-empty docker rm -f 
	-docker volume ls | awk -F' ' 'NR>1 {print $$2}' | xargs --no-run-if-empty docker volume rm
	-docker image ls | awk -F' ' 'NR>1 {print $$3}' | xargs --no-run-if-empty docker rmi
	-docker volume prune -f
	-docker network prune -f
	-docker image prune -f
	-docker system prune -f
re: fclean
	$(MAKE) all

.PHONY: all up build start restart config stop down \
		vol clean fclean re purge cert del_cert cert_exists \
		ls info info-db log log-sv log-app log-db \
		login-sv login-app login-db \
