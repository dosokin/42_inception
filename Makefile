path = requirements

all : volumes build start

build :
	docker compose -f srcs/docker-compose.yml build

start :
	docker compose -f srcs/docker-compose.yml up -d --build

stop :
	docker compose -f srcs/docker-compose.yml down

clean : stop
	docker container prune -f
	docker image prune -a -f

fclean : clean deletevolumes
	docker system prune -a

deletevolumes:
	sudo rm -rf /home/dosokin/data/mariadb
	sudo rm -rf /home/dosokin/data/wordpress
	sudo rm -rf /home/dosokin/data/adminer

volumes :
	sudo mkdir -p /home/dosokin/data/mariadb
	sudo chmod 777 /home/dosokin/data/mariadb
	sudo mkdir -p /home/dosokin/data/wordpress
	sudo chmod 777 /home/dosokin/data/wordpress
	sudo mkdir -p /home/dosokin/data/adminer
	sudo chmod 777 /home/dosokin/data/adminer

re : stop fclean all
