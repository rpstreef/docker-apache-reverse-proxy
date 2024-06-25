# Flexible Development Environment

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A versatile, fully automated virtualized development environment. This setup leverages Vagrant, VirtualBox, and Docker to create a consistent, easily reproducible, and highly adaptable development infrastructure.

> See this article for more details and an explanation.

## Features

- **Flexible Infrastructure**: Easily customizable for various tech stacks
- **Fully Automated Setup**: Get up and running with a single command
- **Virtualized Environment**: Runs on VirtualBox, managed by Vagrant
- **Containerized Services**: Uses Docker Compose for easy service management and scalability

### Example Configuration

This repository includes an example setup for a PHP/Laravel environment, demonstrating how to configure:

- Apache as a Gateway
- PHP with Apache for front-end
- Laravel API
- Redis Cache with Redis Commander
- MySQL database with PHPMyAdmin

However, the infrastructure is designed to be easily adapted for other tech stacks and services.

## Prerequisites

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [Git](https://git-scm.com/)

## Quick Start
1. Clone this repository: git clone https://github.com/yourusername/flexible-dev-environment.git
2. Navigate to the project directory: cd flexible-dev-environment
3. Start the Vagrant environment: `vagrant up` to install with Vagrant to VirtualBox.
4. Select network card with internet access.
5. Once installed, connect with `vagrant ssh`, for ssh access.
6. Type `ip address` take note of the <ip address> for your network card.
7. Now you can access your services via the browser with your <ip address> (using the PHP/Laravel as example):
- Front-end: `http://<ip address>/`
- API: `http://<ip address>/api/`
- Redis Commander: `http://<ip address>/cache/`
- PHPMyAdmin: `http://<ip address>/phpmyadmin/`

## Customizing Your Environment

This setup can be easily adapted for different tech stacks:

1. Modify the `docker-compose.yml` file to include your required services
2. Update the `Vagrantfile` if you need to change VM configurations and Ubuntu installations and dependencies.

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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
