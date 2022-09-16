# Make file for building application

SHELL := /bin/bash
current_dir = $(shell pwd)
CONTAINER_REGISTRY := denis256/k8s-app
NAMESPACE := k8s-app

.FORCE:

build: .FORCE
	cd app && go build

run-local: build
	cd app && export DB_URL="host=localhost port=5432 user=postgres password=123456 dbname=postgres sslmode=disable" && ./k8s-app


container:
	$(eval TAG:=$(shell git describe --tags --abbrev=12 --dirty --broken))
	echo "Building image with tag: $(TAG)"
	docker build . -t "k8s-app:$(TAG)"
	docker tag "k8s-app:$(TAG)" k8s-app:local

push: container
	$(eval TAG:=$(shell git describe --tags --abbrev=12 --dirty --broken))
	docker tag "k8s-app:$(TAG)" "$(CONTAINER_REGISTRY):$(TAG)"
	docker push "$(CONTAINER_REGISTRY):$(TAG)"

deploy-k8s:
	$(eval TAG:=$(shell git describe --tags --abbrev=12 --dirty --broken))
	helm -n $(NAMESPACE) upgrade --install --create-namespace k8s-app ./helm --values ./helm-values.yaml --set "image.tag=$(TAG)"
