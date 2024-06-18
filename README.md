# Docker compose with Apache 2 Reverse Proxy

Docker compose example with Apache 2 as a reverse proxy 

`make up` to build and run all the containers.
`make down` to bring down all the containers.
`dry` to monitor containers and access logs and tail them `f` easily.

## Git access

In the `Vagrantfile` at the top, please adjust:

```shell
 # Variables
  git_user_email = 'youremail@mail.com'
  git_user_name = 'gitusername'
```

Further down in the `Vagrantfile`, this line is executed to tell git to use the `store` credential helper.

```
git config --global credential.helper store
```

After the VM is installed with Vagrant, execute this on the commandline to set your `Personal access token` for GitHub.

```shell
git credential-store store <<EOF
protocol=https
host=github.com   # Replace with your Git provider's hostname
username=<your-username>   # Replace with your Git username
password=<personal-access-token>
EOF
```

these are all stored in `cat ~/.git-credentials`

Now you can freely `git push` without authentication requests.


## Makefile for quick access

Enter `make' for this help list:

```bash
@echo 'make install				- Install VirtualMachine with Docker and LangFlow'
@echo 'make update				- Update the Vagrant VirtualMachine'
@echo 'make remove				- Remove this VirtualMachine'
@echo 'make vm					- Connect to VirtualBox via SSH and (if required) starts VirtualBox first'
@echo 'make vm-stop				- Stops VirtualBox'
@echo 'make up					- Docker containers build (if required) and up as a daemon (in the background)'
@echo 'make down				- Docker containers down'
```

## .env files for configuration

Create an `.env` file in the root directory of this git repo, and all your configuration:

```bash
# MySQL
MYSQL_ROOT_PASSWORD=root_password
MYSQL_DATABASE=my_database
MYSQL_USER=my_user
MYSQL_PASSWORD=my_password

# Redis Commander
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_NAME=local
REDIS_PASSWORD=

# Laravel
APP_KEY=base64:ezEe4jH/6EUM2fMWLnco3kuMz1OMStq/XfV456ZwMhc=

# User config
UID=1000
GID=1000
```

## Create basic laravel test app:

Force composer to use SSL: `composer config -g repo.packagist composer https://packagist.org` 

Ensure you have PHP Curl installed, this could prevent downloading from packagist: `sudo apt install php8.1-curl`

Run in `./api`: `composer create-project --prefer-dist laravel/laravel .`

The configuration default should be changed after you've created a database technical user:

```shell
DB_USERNAME: root
DB_PASSWORD: ${MYSQL_ROOT_PASSWORD}
```

### Host machine user and group id

Ensure the API Laravel service runs on the same user id and group id as your host system!

This will avoid disk permission and ownership problems when sharing files between a container and the host machine.

```shell
APACHE_RUN_USER: "#${UID}"
APACHE_RUN_GROUP: "#${GID}"
```

## PHPMyAdmin

Ensure `PMA_ABSOLUTE_URI` configuration matches the forwarding rule such that after login the path remains e.g. `localhost/phpmyadmin/index.php?`

