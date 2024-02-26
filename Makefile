REGISTRY_HOST=docker.io
USERNAME=ripl
NAME=libbot2-docker

IMAGE=$(USERNAME)/$(NAME)


# Common variables
LCM_VERSION = "1.5.0"

# Tag: latest
BASE_IMAGE_LATEST = "ripl/lcm:latest"
BUILD_IMAGE_LATEST = "${IMAGE}:latest"

.PHONY: pre-build docker-build build release showver \
        push cleanup

build: pre-build docker-build ## builds a new version of the container image(s)

pre-build: ## Update the base environment images
	docker pull $(BASE_IMAGE_LATEST)


post-build:


pre-push:


post-push:


docker-build:

	# Build latest
	docker buildx build --platform linux/arm64/v8,linux/amd64 --tag $(BUILD_IMAGE_LATEST) -f Dockerfile .

release: build push     ## builds a new version of your container image(s), and pushes it/them to the registry

push: pre-push do-push post-push

do-push:
	# Push lateset
	docker buildx build --platform linux/arm64/v8,linux/amd64 --push --tag $(BUILD_IMAGE_LATEST) -f Dockerfile .

cleanup: ## Remove images pulled/generated as part of the build process
	docker rmi $(BASE_IMAGE_LATEST)
	docker rmi $(BUILD_IMAGE_LATEST)

help:   ## show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | grep -v fgrep | sed -e 's/\([^:]*\):[^#]*##\(.*\)/printf '"'%-20s - %s\\\\n' '\1' '\2'"'/' |bash