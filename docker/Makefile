#########################################################
# imports
#########################################################

include .env
PROJECT_PATH := ${PROJECT_PATH}
CONTAINER_SOURCE_ROOT := ${CONTAINER_SOURCE_ROOT}
CONTAINER_USER_NAME := ${CONTAINER_USER_NAME}

#########################################################
# variables
#########################################################

COMPOSE := HOST_USER_ID=`id -u` HOST_GROUP_ID=`id -g` docker-compose
BUILD := $(COMPOSE) build --no-cache
UP := $(COMPOSE) up -d
DOWN := $(COMPOSE) down
EXEC = $(COMPOSE) exec --user $(CONTAINER_USER_NAME) $(CONTAINER) bash $(ARG)
CONTAINER =
ARG =

# docker services (container name)
PYTHON := python

#########################################################
# if include source not exists commands
#########################################################

.env:
	@cp -n .env.example .env

#########################################################
# make commands
#########################################################

init:
	@make build up catch-up

build:
	@$(BUILD)

up:
	@$(UP)

catch-up:
	$(eval CONTAINER := $(PYTHON))
	$(eval ARG := -c "cd $(CONTAINER_SOURCE_ROOT) && poetry install")
	@$(EXEC)

exec-python:
	$(eval CONTAINER := $(PYTHON))
	$(eval ARG := -c "cd $(CONTAINER_SOURCE_ROOT) && bash")
	@$(EXEC)

down:
	@$(DOWN)

remove:
	@$(DOWN) --rmi all --volumes --remove-orphans