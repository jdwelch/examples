CONTAINER_NAME = knative-hellonode
GCP_PROJECT = proj-genesis

all: clean build deploy

build:
	@echo "🔘 Building '$(CONTAINER_NAME)' container..."
	docker build -t $(CONTAINER_NAME) .
	@echo "🔘 Tagging '$(CONTAINER_NAME)' container..."
	docker tag $(CONTAINER_NAME) gcr.io/$(GCP_PROJECT)/$(CONTAINER_NAME):latest
	@echo "🔘 Pushing '$(CONTAINER_NAME)' container..."
	docker push gcr.io/$(GCP_PROJECT)/$(CONTAINER_NAME):latest

run-docker:
	docker run -it -p 8080:8080 gcr.io/$(GCP_PROJECT)/$(CONTAINER_NAME):latest

run:
	npm start

deploy:
	@echo "🔘 Deploying to cluster..."
	kubectl apply -f service.yaml

stop:
	@echo "🔘 Removing from cluster..."
	kubectl delete -f service.yaml

clean:
	# @echo "🔘 Cleaning workspace..."

.PHONY: build clean all