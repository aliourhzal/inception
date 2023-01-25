DB_PATH = srcs/requirements/mariadb
WP_PATH = srcs/requirements/wordpress
NG_PATH = srcs/requirements/nginx
DC_PATH = srcs/docker-compose.yml

MARIADB = $(DB_PATH)/conf/50-server.cnf $(DB_PATH)/tools/sql-conf.sh $(DB_PATH)/.dockerignore $(DB_PATH)/dockerfile
WORDPRESS = $(WP_PATH)/conf/www.conf $(WP_PATH)/tools/script.sh $(WP_PATH)/.dockerignore $(WP_PATH)/dockerfile
NGINX = $(NG_PATH)/conf/wordpress $(NG_PATH)/tools/script.sh $(NG_PATH)/.dockerignore $(NG_PATH)/dockerfile

all: $(MARIADB) $(WORDPRESS) $(NGINX)
	mkdir -p /home/aourhzal/data/wp
	mkdir -p /home/aourhzal/data/db
	docker-compose -f $(DC_PATH) build --no-cache
	docker-compose -f $(DC_PATH) up

clean:
	docker-compose -f $(DC_PATH) down

fclean: clean
	docker system prune -af
	docker volume ls -q | xargs docker volume rm 
	rm -rf /home/aourhzal/data