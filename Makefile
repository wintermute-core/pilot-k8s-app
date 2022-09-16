# Make file for building application

SHELL := /bin/bash
current_dir = $(shell pwd)

.FORCE:

build: .FORCE
	cd app && go build