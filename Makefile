build:
	@@go build -o bin/backend-golang cmd/main.go

test:
	@go test -v ./...

run: build
	@./bin/backend-golang