NAME		= inception
SV			= nginx
APP			= wordpress
DB			= mariadb
FIX_CTNR	= container
IMG_SV		= $(NAME)_$(SV)
IMG_APP		= $(NAME)_$(APP)
IMG_DB		= $(NAME)_$(DB)
CTNR_SV		= $(SV)-$(FIX_CTNR)
CTNR_APP	= $(APP)-$(FIX_CTNR)
CTNR_DB		= $(DB)-$(FIX_CTNR)

up: dir
	docker compose up -d --build
dir:
	-mkdir -p ~/data
	-mkdir -p ~/data/nginx
	-mkdir -p ~/data/mariadb
build: dir
	-docker image rm --force $(IMG_SV) $(IMG_APP) $(IMG_DB)
	docker compose build --no-cache
start:
	docker compose start
login-sv:
	docker exec -it $(CTNR_SV) /bin/sh
login-app:
	docker exec -it $(CTNR_APP) /bin/sh
login-db:
	docker exec -it $(CTNR_DB) /bin/sh
log-sv:
	docker logs --tail 50 --follow --timestamps $(CTNR_SV)
log-app:
	docker logs --tail 50 --follow --timestamps $(CTNR_APP)
log-db:
	docker logs --tail 50 --follow --timestamps $(CTNR_DB)
stop:
	docker-compose stop
down: stop
	docker-compose down
clean: stop
	-docker compose down -v
	-docker container rm --force $(CTNR_SV) $(CTNR_APP) $(CTNR_DB)
	-docker image rm --force $(IMG_SV) $(IMG_APP) $(IMG_DB)
fclean:
	-docker-compose down --rmi all --volumes --remove-orphans
	-docker image ls | awk -F' ' 'NR>1 {print $3}' | xargs docker rmi
	-docker image prune -f
	-docker system prune -f
	-docker volume prune -f
	-docker network prune -f
	-rm -rf ./data
re: clean build up

.PHONY: up build login-sv login-app login-db log-sv log-app log-db stop down clean fclean re
