build:
	@docker buildx --platform="linux/amd64" . -t eximpe/action-runner:v1.4
push:
	@docker push eximpe/action-runner:v1.3