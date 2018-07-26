all: clean build deploy

build:
	@echo "🔘 Building application..."
	npm run build

deploy:
	@echo "🔘 Deploying to cluster..."
	pulumi update --yes
	@echo "🔘 Locating services..."
	kubectl get services

stop:
	@echo "🔘 Removing from cluster..."
	pulumi destroy --yes

clean:
	# @echo "🔘 Cleaning workspace..."

.PHONY: build clean all