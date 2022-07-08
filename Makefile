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

parla-import:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py parlametria --import

shell:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py shell