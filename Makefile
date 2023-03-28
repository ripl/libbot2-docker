REGISTRY_HOST=docker.io
USERNAME=ripl
NAME=libbot2-docker

IMAGE=$(USERNAME)/$(NAME)


# Common variables
LCM_VERSION = "1.4.0"

# Tag: latest
BASE_IMAGE_LATEST = "ripl/lcm:latest"
BUILD_IMAGE_LATEST = "${IMAGE}:latest"

# Tag:
PREVIOUS_LCM_VERSION = "1.4.0"
BASE_IMAGE_PREVIOUS_LCM_VERSION = ripl/lcm:${PREVIOUS_LCM_VERSION}_focal
BUILD_IMAGE_PREVIOUS_LCM_VERSION = ${IMAGE}:${PREVIOUS_LCM_VERSION}


.PHONY: pre-build docker-build build release showver \
        push cleanup

build: pre-build docker-build ## builds a new version of the container image(s)

pre-build: ## Update the base environment images
	docker pull $(BASE_IMAGE_LATEST)
	docker pull $(BASE_IMAGE_PREVIOUS_LCM_VERSION)


post-build:


pre-push:


post-push:


docker-build:

	docker build -t $(BUILD_IMAGE_LATEST) -f Dockerfile ./

	#docker build -t $(BUILD_IMAGE_PREVIOUS_LCM_VERSION) -f Dockerfile.previous_lcm_version ./

release: build push     ## builds a new version of your container image(s), and pushes it/them to the registry

push: pre-push do-push post-push

do-push:
	docker push $(BUILD_IMAGE_LATEST)
	#docker push $(BUILD_IMAGE_PREVIOUS_LCM_VERSION)

cleanup: ## Remove images pulled/generated as part of the build process
	docker rmi $(BUILD_IMAGE_LATEST)
	#docker rmi $(BUILD_IMAGE_PREVIOUS_LCM_VERSION)

help:   ## show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | grep -v fgrep | sed -e 's/\([^:]*\):[^#]*##\(.*\)/printf '"'%-20s - %s\\\\n' '\1' '\2'"'/' |bash