DOCKER_IMAGE_VERSION=v1
DOCKER_IMAGE_NAME=kipp/rpi-digitalfoosball
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	#docker tag -f $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/echo "Success."

version:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/bash -l -c "cd /data/repos/jkb-digitalfoosball && git branch -a && git tag"
