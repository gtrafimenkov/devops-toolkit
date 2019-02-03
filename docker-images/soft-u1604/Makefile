# SPDX-License-Identifier: MIT
# Copyright (c) 2019 Gennady Trafimenkov

default:
	echo doing nothing

DT := $(shell date +%Y%m%d-%H%M%S)

build-fresh:
	docker build --pull --no-cache -f Dockerfile.fresh  . -t soft:u1604-new-latest
	docker images | head -n 2
	echo "Try it with: docker run --rm -it soft:u1604-new-latest"

build-update:
	docker build --pull --no-cache -f Dockerfile.update . -t soft:u1604-new-latest
	docker images | head -n 2
	echo "Try it with: docker run --rm -it soft:u1604-new-latest"

upload-new-latest:
	docker tag soft:u1604-new-latest quay.io/gtrafimenkov/soft:u1604-latest
	docker tag soft:u1604-new-latest quay.io/gtrafimenkov/soft:u1604-$(DT)
	docker push quay.io/gtrafimenkov/soft:u1604-latest
	docker push quay.io/gtrafimenkov/soft:u1604-$(DT)
	docker rmi soft:u1604-new-latest

test:
	docker run --rm -it soft:u1604-new-latest
