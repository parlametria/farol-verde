SERVER_CONTAINER=farolwagtail
TEST_CONTAINER=faroltests

attach:
	docker exec -it $(SERVER_CONTAINER) bash

test-attach:
	docker exec -it $(TEST_CONTAINER) bash

up:
	docker-compose up

stop:
	docker-compose stop

rm:
	docker-compose rm

test:
	docker exec $(TEST_CONTAINER) /bin/bash -c "cd /tests && cypress run"

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

proposicoes-change-adhesion:
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py proposicoes --change-adhesion

proposicoes-votos-interesse: # https://github.com/parlametria/farol-verde/issues/147
	docker exec -it $(SERVER_CONTAINER) poetry run python manage.py proposicoes_interesse --votos-senadores-proposicoes-interesse

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
