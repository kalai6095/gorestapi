#how to use makefile to build go   ref---> https://tutorialedge.net/golang/makefiles-for-go-developers/
hello:
	echo "Hello"

compile:
	echo "Compiling for every OS and Platform"
	GOOS=freebsd GOARCH=386 go build -o bin/main-freebsd-386 main.go
	GOOS=linux GOARCH=386 go build -o bin/main-linux-386 main.go
	GOOS=windows GOARCH=386 go build -o bin/main-windows-386 main.go

build:
	go build -o bin/gorestapi main.go

run:
	go run main.go

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
	