NAME=goagent
REGISTRYHOST=
USERNAME=mengbo

# Change this to suit your needs.
GOAGENT_LISTEN_USERNAME=goagent
GOAGENT_LISTEN_PASSWORD=goagent
GOAGENT_GAE_APPID=docker-goagent
GOAGENT_GAE_PASSWORD=docker-goagent

DOCKER_VOLUME=-v /usr/local/share/ca-certificates:/usr/local/share/ca-certificates

DOCKER_RUN_ENV=-e GOAGENT_LISTEN_USERNAME="$(GOAGENT_LISTEN_USERNAME)" \
	       -e GOAGENT_LISTEN_PASSWORD="$(GOAGENT_LISTEN_PASSWORD)" \
	       -e GOAGENT_GAE_APPID="$(GOAGENT_GAE_APPID)" \
	       -e GOAGENT_GAE_PASSWORD="$(GOAGENT_GAE_PASSWORD)"

RUNNING:=$(shell docker ps | grep $(NAME) | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep $(NAME) | cut -f 1 -d ' ')

all: build

build:
	docker build -t $(REGISTRYHOST)$(USERNAME)/$(NAME) .

upload: clean
	docker run --name $(NAME) -t -i -p 8087:8087 \
		$(DOCKER_VOLUME) $(DOCKER_RUN_ENV) $(USERNAME)/$(NAME) \
		/opt/goagent/uploadserver

run: clean
	docker run --name $(NAME) -d -p 8087:8087 \
		$(DOCKER_VOLUME) $(DOCKER_RUN_ENV) $(USERNAME)/$(NAME)
	sleep 10
	docker cp $(NAME):/opt/goagent/local/CA.crt .

bash: clean
	docker run --name $(NAME) -t -i -p 8087:8087 \
		$(DOCKER_VOLUME) $(DOCKER_RUN_ENV) $(USERNAME)/$(NAME) \
		/bin/bash

# Removes existing containers.
clean:
ifneq ($(strip $(RUNNING)),)
	docker stop $(RUNNING)
endif
ifneq ($(strip $(ALL)),)
	docker rm $(ALL)
endif
