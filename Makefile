# Makefile
SHELL := /bin/bash

# Default target executed when no arguments are given to make.
all: help

install:
		vagrant up

update:
		vagrant provision

remove:
		vagrant destroy

up:
		docker-compose up --build -d

down:
		docker-compose down

vm: 
		./scripts/ssh-and-start-vm.sh

vm-stop: 
		./scripts/stop-vm.sh

help:
	@echo '----'
	@echo 'make install				- Install VirtualMachine with Docker and LangFlow'
	@echo 'make update				- Update the Vagrant VirtualMachine'
	@echo 'make remove				- Remove this VirtualMachine'
	@echo 'make vm					- Connect to VirtualBox via SSH and (if required) starts VirtualBox first'
	@echo 'make vm-stop				- Stops VirtualBox'
	@echo 'make up					- Docker containers build (if required) and up as a daemon (in the background)'
	@echo 'make down				- Docker containers down'