PATH := $(PATH):$(shell go env GOPATH)/bin

.PHONY: build test run migration migrate-up migrate-down

build:
	@@go build -o bin/backend-golang cmd/main.go

test:
	@go test -v ./...

run: build
	@./bin/backend-golang

migration:
	@which migrate >/dev/null 2>&1 || GOBIN="$(shell go env GOPATH)/bin" go install github.com/golang-migrate/migrate/v4/cmd/migrate@latest
	@if [ -z "$(NAME)" ]; then echo "Usage: make migration NAME=your_migration_name"; exit 1; fi
	@migrate create -ext sql -dir cmd/migrate/migrations "$(NAME)"

migrate-up:
	@go run cmd/migrate/main.go up

migrate-down:
	@go run cmd/migrate/main.go down