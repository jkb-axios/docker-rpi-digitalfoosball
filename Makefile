DOCKER_IMAGE_VERSION=0.1.0
DOCKER_IMAGE_NAME=jkb-axios/rpi-digitalfoosball
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	docker tag -f $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/echo "Success."

version:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) python --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) git --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) gem --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) rvm --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) ruby --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) node --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) npm --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) couchdb -V
	docker run --rm $(DOCKER_IMAGE_TAGNAME) couchpy --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) soca --version
