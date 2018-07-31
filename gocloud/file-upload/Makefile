all: clean vet build deploy

lint: $(GOPATH)/bin/golint
	@echo "🔘 Linting... (ignoring style errors in AWS SDK/Provider)"
	@lint=`golint ./... | grep -v ^vendor/ | grep -E -v -e ${LINTIGNOREINITIALISMS}`; \
	if [ "$$lint" != "" ]; then echo "$$lint"; exit 1; fi

vet:
	@echo "🔘 Running go vet..."
	@go vet

build: vet
	@echo "🔘 Building..."
	mkdir -p build/
	go build -o build/upload
	@echo "📣 check ./build directory for binaries"

clean:
	@echo "🔘 Cleaning build dir..."
	@rm -rf build

deploy:
# @echo "🔘 Deploying to..."