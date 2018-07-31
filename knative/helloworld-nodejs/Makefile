ifndef GCP_PROJECT
$(error GCP_PROJECT is not set)
endif

CONTAINER_NAME = knative-hellonode
CLUSTER_NAME = `kubectl config current-context`

all: clean build deploy

build:
	@echo "🔘 Building '$(CONTAINER_NAME)' container with Cloud Build..."
	gcloud builds submit --tag gcr.io/$(GCP_PROJECT)/$(CONTAINER_NAME):latest .

build-docker:
	@echo "🔘 Building '$(CONTAINER_NAME)' container with Docker..."
	docker build -t $(CONTAINER_NAME) .
	@echo "🔘 Tagging '$(CONTAINER_NAME)' container..."
	docker tag $(CONTAINER_NAME) gcr.io/$(GCP_PROJECT)/$(CONTAINER_NAME):latest
	@echo "🔘 Pushing '$(CONTAINER_NAME)' container to GCP Container Registry..."
	docker push gcr.io/$(GCP_PROJECT)/$(CONTAINER_NAME):latest

run-docker:
	docker run -it -p 8080:8080 gcr.io/$(GCP_PROJECT)/$(CONTAINER_NAME):latest

run:
	@echo "🔘 Starting app..."
	npm start

deploy:
	@echo "🔘 Deploying to cluster $(CLUSTER_NAME)..."
	kubectl apply -f service.yaml

stop:
	@echo "🔘 Removing from cluster $(CLUSTER_NAME)..."
	kubectl delete -f service.yaml

clean:
	@echo "🔘 Stopping any running containers..."
	docker ps -a | grep "$(CONTAINER_NAME)" | awk '{print $$1}' | xargs docker rm --force
	@echo "🔘 Removing container images..."
	docker images | grep "$(CONTAINER_NAME)" | awk '{print $$1 ":" $$2}' | xargs docker rmi

.PHONY: build clean all