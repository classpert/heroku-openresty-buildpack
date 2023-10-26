OPENRESTY_VERSION ?= 1.21.4.2
LUAROCKS_VERSION ?= 3.9.2

build: build-heroku-18 build-heroku-20 build-heroku-22

build-heroku-18:
	@echo "Building OpenResty in Docker for heroku-18 ..."
	@DOCKER_DEFAULT_PLATFORM=linux/amd64 docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-18" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:18-build bin/build /buildpack/dist/openresty-heroku-18.tar.gz

build-heroku-20:
	@echo "Building OpenResty in Docker for heroku-20 ..."
	@DOCKER_DEFAULT_PLATFORM=linux/amd64 docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-20" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:20-build bin/build /buildpack/dist/openresty-heroku-20.tar.gz

build-heroku-22:
	@echo "Building OpenResty in Docker for heroku-22 ..."
	@DOCKER_DEFAULT_PLATFORM=linux/amd64 docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-22" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:22-build bin/build /buildpack/dist/openresty-heroku-22.tar.gz

shell-heroku-18:
	@echo "Start a Docker shell for heroku-18 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-18" -w /buildpack heroku/heroku:18-build bash


shell-heroku-20:
	@echo "Start a Docker shell for heroku-20 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-20" -w /buildpack heroku/heroku:20-build bash

release:
	git commit -a -m "Rebuilding stacks"
	git push origin master
