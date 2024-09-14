NAME			:= inception
export SV		:= nginx
export APP		:= wordpress
export DB		:= mariadb
export DATADIR	:= /home/${USER}/data
export ENVFILE	:= ../.env
SRCDIR			:= ./srcs
YAML			:= -f $(SRCDIR)/docker-compose.yml
FIX_IMG			:= incep-img
FIX_CTNR		:= incep-ctnr
export IMG_SV	:= $(FIX_IMG)_$(SV)
export IMG_APP	:= $(FIX_IMG)_$(APP)
export IMG_DB	:= $(FIX_IMG)_$(DB)
export CTNR_SV	:= $(FIX_CTNR)_$(SV)
export CTNR_APP	:= $(FIX_CTNR)_$(APP)
export CTNR_DB	:= $(FIX_CTNR)_$(DB)

up: dir
	docker compose $(YAML) up -d --build
dir:
	-mkdir -p $(DATADIR)
	-mkdir -p $(DATADIR)/$(APP)
	-mkdir -p $(DATADIR)/$(DB)
build: dir
	-docker image rm --force $(IMG_SV) $(IMG_APP) $(IMG_DB)
	docker compose $(YAML) build --no-cache
start:
	docker compose $(YAML) start
ls:
	docker image ls
	docker container ls
	docker ps
	docker compose $(YAML) ls
	docker compose $(YAML) ps
login-sv:
	docker exec -it $(CTNR_SV) /bin/sh
login-app:
	docker exec -it $(CTNR_APP) /bin/sh
login-db:
	docker exec -it $(CTNR_DB) /bin/sh
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
down: stop
	docker-compose $(YAML) down
clean: stop
	-docker compose $(YAML) down -v
	-docker image ls | grep '<none>' | awk -F' ' 'NR>1 {print $3}' | xargs docker rmi --force
	-docker container rm --force $(CTNR_SV) $(CTNR_APP) $(CTNR_DB)
	-docker image rm --force $(IMG_SV) $(IMG_APP) $(IMG_DB)
fclean:
	-docker compose $(YAML) down --rmi all --volumes --remove-orphans
	-docker image ls | awk -F' ' 'NR>1 {print $3}' | xargs docker rmi
	-docker image prune -f
	-docker system prune -f
	-docker volume prune -f
	-docker network prune -f
	-rm -rf ./data
re: clean build up

.PHONY: up build start stop down \
		dir clean fclean re \
		ls log login-sv login-app login-db log-sv log-app log-db
