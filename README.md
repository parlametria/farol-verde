# Wagtail boilerplate
Estrutura inicial de um website contendo uma página inicial e um blog.

-----
## Subindo Ambiente local
Para subir o ambiente de desenvolvimento, utilize o comando abaixo:

    make up

Isso irá criar um container da aplicação a partir do arquivo `docker-compose.yml` e subi-lo.

Após a construção do container e sua execução, é necessário executar as migrações do banco de dados. Para isso, utilize o comando abaixo:

    make migrate

Pronto! **A aplicação estará disponível no endereço em [http://localhost:4000/](http://localhost:4000/).**

## Área Administrativa
Para acessar a área administrativa, é necessário criar o usuário administrador. Execute o comando `make createsu`, registre suas credenciais e tente logar em [http://localhost:4000/admin](http://localhost:4000/admin).


