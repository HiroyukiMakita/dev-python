#########################################################
# imports
#########################################################

include .env
PROJECT_PATH := ${PROJECT_PATH}
CONTAINER_SOURCE_ROOT := ${CONTAINER_SOURCE_ROOT}
CONTAINER_USER_NAME := ${CONTAINER_USER_NAME}
COMPOSE_PROJECT_NAME := ${COMPOSE_PROJECT_NAME}
PYTHON_VERSION := ${PYTHON_VERSION}

#########################################################
# variables
#########################################################

COMPOSE := HOST_USER_ID=`id -u` HOST_GROUP_ID=`id -g` docker compose
BUILD := $(COMPOSE) build --no-cache
UP := $(COMPOSE) up -d
DOWN := $(COMPOSE) down
EXEC = $(COMPOSE) exec --user $(CONTAINER_USER_NAME) $(CONTAINER) bash $(ARG)
CONTAINER =
ARG =

# docker services (container name)
PYTHON := python

#########################################################
# parallel counts
#########################################################
JOBS = 1
ifeq ($(shell uname),Linux)
# Linux
	JOBS = `grep cpu.cores /proc/cpuinfo | sort -u | sed 's/[^0-9]//g'`
else ifeq ($(shell uname),Darwin)
# MacOS
	JOBS = `sysctl -a machdep.cpu | grep machdep.cpu.core_count | sed 's/[^0-9]//g'`
endif

#########################################################
# if include source not exists commands
#########################################################

.env:
	@cp -n .env.example .env

#########################################################
# make commands
#########################################################

init:
	@echo "make -j${JOBS}"
	@make build up uv-init

build:
	@+CONTAINER_GIT_USER=`git config --get user.name` CONTAINER_GIT_EMAIL=`git config --get user.email` $(BUILD)

up:
	@$(UP)

up-jupyter:
	$(eval CONTAINER := $(PYTHON))
	$(eval ARG := -c "\
		uv run jupyter kernelspec uninstall docker-py -f || echo 'Kernel docker-py not found, skipping uninstall.' && \
		uv run python -m ipykernel install --user --name=docker-py --display-name \"Python (docker)\" && \
		uv run jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.use_redirect_file=False --NotebookApp.custom_display_url=\"http://0.0.0.0:$(JUPYTER_PORT)/\" --ServerApp.token=''\
	")
	@$(EXEC)

# Dockerfile 内でやるとうまく実行されないのか .venv が作成されないので
# その他 uv sync 後に必要な初期化処理を行う
uv-init:
	$(eval CONTAINER := $(PYTHON))
	$(eval ARG := -c "\
		cd $(CONTAINER_SOURCE_ROOT) && \
		if [ ! -e pyproject.toml ]; then uv init --name ${COMPOSE_PROJECT_NAME}; fi && \
		uv sync && \
		uv python pin ${PYTHON_VERSION} && \
		uv python install && \
		uv run lefthook install && \
		uv run python --version && \
		uv run python hello.py\
	")
	@$(EXEC)

exec-py:
	$(eval CONTAINER := $(PYTHON))
	$(eval ARG := -c "cd $(CONTAINER_SOURCE_ROOT) && bash")
	@$(EXEC)

down:
	@$(DOWN)

remove:
	@$(DOWN) --rmi all --volumes --remove-orphans