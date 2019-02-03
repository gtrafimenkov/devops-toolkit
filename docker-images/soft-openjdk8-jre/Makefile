# SPDX-License-Identifier: MIT
# Copyright (c) 2019 Gennady Trafimenkov

default:
	echo doing nothing

DT := $(shell date +%Y%m%d-%H%M%S)

build-fresh:
	docker build --pull --no-cache -f Dockerfile.fresh  . -t soft:openjdk8-jre-new-latest
	docker images | head -n 2
	echo "Try it with: docker run --rm -it soft:openjdk8-jre-new-latest"

build-update:
	docker build --pull --no-cache -f Dockerfile.update . -t soft:openjdk8-jre-new-latest
	docker images | head -n 2
	echo "Try it with: docker run --rm -it soft:openjdk8-jre-new-latest"

upload-new-latest:
	docker tag soft:openjdk8-jre-new-latest quay.io/gtrafimenkov/soft:openjdk8-jre-latest
	docker tag soft:openjdk8-jre-new-latest quay.io/gtrafimenkov/soft:openjdk8-jre-$(DT)
	docker push quay.io/gtrafimenkov/soft:openjdk8-jre-latest
	docker push quay.io/gtrafimenkov/soft:openjdk8-jre-$(DT)
	docker rmi soft:openjdk8-jre-new-latest

test:
	docker run --rm -it soft:openjdk8-jre-new-latest
