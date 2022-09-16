# Make file for building application

SHELL := /bin/bash
current_dir = $(shell pwd)

.FORCE:

build: .FORCE
	cd app && go build

run-local: build
	cd app && export DB_URL="host=localhost port=5432 user=postgres password=123456 dbname=postgres sslmode=disable" && ./k8s-app
