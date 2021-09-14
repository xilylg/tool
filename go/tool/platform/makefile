GOCMD=go
BUILD=$(GOCMD) build
BIN=./bin/api-platform

.PHONY: local

local:
	$(BUILD) -o $(BIN) -v cmd/main.go
	$(BIN)