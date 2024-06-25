# Docker compose with Apache 2 Reverse Proxy

Docker compose example with Apache 2 as a reverse proxy 

## Pre-Requisites:

1. Install Vagrant using [these](https://developer.hashicorp.com/vagrant/docs/installation) instructions
2. Install VirtualBox using [these](https://www.virtualbox.org/wiki/Downloads) instructions.

## Install:

1. `vagrant up` to install with Vagrant to VirtualBox.
2. Once installed, connect with `vagrant ssh`.
3. `dry` to monitor containers and access logs and tail them pressing `f` easily.

## (Optional) Makefile for quick access

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

# A few notes about this setup

## .env files for configuration

Normally, you would not commit the `.env` file due to passwords etc. 

This project requires the follwing configuration in the root directory of this git repo:

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

## Host machine user and group id

Ensure the API Laravel service runs on the same user id and group id as your host system!

This will avoid disk permission and ownership problems when sharing files between a container and the host machine.

```shell
APACHE_RUN_USER: "#${UID}"
APACHE_RUN_GROUP: "#${GID}"
```

## PHPMyAdmin

Ensure `PMA_ABSOLUTE_URI` configuration matches the forwarding rule such that after login the path remains e.g. `localhost/phpmyadmin/index.php?`


# Troubleshooting

## Connectivity issues?

In case you want to troubleshoot from a specific container, do the following:

If it's the `gateway` container:

```bash
docker exec -it gateway bash
apt-get update
apt-get install -y curl iputils-ping
```

Now you can check the connectivity to other services with;

```bash
ping phpmyadmin
curl -I http://phpmyadmin:80
```