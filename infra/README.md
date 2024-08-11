# Infra

### Note for local development
The code in this directory is for production infrastructure. For local development, go to the root of the project and
use run `./vendor/bin/sail up -d` to start the development environment.

### Terraform
We use Terraform to provision an EC2 and related resources.

### Docker
We use Docker to run PHP, Nginx, and Postgres.

### Docker command examples
To run a command in the PHP container:

```shell
docker-compose --env-file .env -f infra/docker/docker-compose.yml exec php [command]
```
e.g.:
```shell
docker-compose --env-file .env -f infra/docker/docker-compose.yml exec php php artisan migrate
```

To run a command in the Node container:
```shell
docker-compose --env-file .env -f infra/docker/docker-compose.yml exec node [command]
```
e.g.:
```shell
docker-compose --env-file .env -f infra/docker/docker-compose.yml exec node npm run build
```
