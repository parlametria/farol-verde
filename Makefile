SERVER_CONTAINER=farol_verde_server

attach:
	docker exec -it $(SERVER_CONTAINER) bash

up:
	docker-compose up

stop:
	docker-compose stop

rm:
	docker-compose rm

createsu:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py createsuperuser

migrate:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py makemigrations && docker exec -it $(SERVER_CONTAINER) poetry run python manage.py migrate

makemigrations:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py makemigrations

candidatos-import:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py candidatos --import

camara-import:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py camara --import

senado-import:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py senado --import

proposicoes-import:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py proposicoes --import

proposicoes-update-date:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py proposicoes --update-date

adesao-to-csv:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py adesao --all-candidates-adhesion-csv

candidates-votos-to-csv:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py adesao --candidates-votos-to-csv

tse-process:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py tse --process

vetos-import:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py vetos --import

shell:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py shell
