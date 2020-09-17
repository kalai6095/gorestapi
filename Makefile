#how to use makefile to build go   ref---> https://tutorialedge.net/golang/makefiles-for-go-developers/
SHELL= /bin/sh

PLATFORMS := linux/amd64 darwin/amd64
temp = $(subst /, ,$@)
os = $(word 1, $(temp))
arch = $(word 2, $(temp))

BIN:=gorestapi
OS_NAME :=$(shell uname -s | tr A-Z a-z)
HASH := $(shell git rev-parse --short HEAD)
COMMIT_DATE :=$(shell git show -s --format=%ci ${HASH})
BUILD_DATE:=$(shell date -u '+%d-%m-%yT%H:%M:%SZ')
VERSION:= ${HASH}(${COMMIT_DATE})
GOOS:=darwin
BUILD_ENV :=CGO_ENABLED=0 GOOS=${GOOS} GOARCH=amd64


hello:
	echo "${PLATFORMS}  -- ${temp} -- ${os} -- ${arch} -- ${OS_NAME}"

#to build diff version of executable
compile:
	echo "Compiling for every OS and Platform"
	GOOS=freebsd GOARCH=386 go build -o bin/main-freebsd-386 main.go
	GOOS=linux GOARCH=386 go build -o bin/main-linux-386 main.go
	GOOS=windows GOARCH=386 go build -o bin/main-windows-386.exe main.go


build:
	go build -o 'bin/${OS_NAME}/${BIN}'

boot:
	go mod download

run: start
	

start: 	bin/${OS_NAME}/${BIN}


dev: clean
		 go build -o 'bin/${OS_NAME}/${BIN}'

watch:
		CompileDaemon -build="make dev" -command="bin/$(OS_NAME)/${BIN}" -color="true"

clean:
	go clean
	go mod tidy
	rm -rf bin

.PHONY: help


all: hello build compile

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

help:
	@echo ''
	@echo 'Usage:'
	@echo ' ${YELLOW} make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	