IMAGE   := pypiserver
PORT    := 8080
PACKAGES := $(PWD)/packages

.PHONY: build start stop upload

build:
	docker build -t $(IMAGE) .

start: build
	docker run -d \
		--name $(IMAGE) \
		-p $(PORT):8080 \
		-v $(PACKAGES):/packages \
		$(IMAGE)

stop:
	docker stop $(IMAGE) && docker rm $(IMAGE)

upload:
	@test -n "$(WHEEL)" || (echo "Usage: make upload WHEEL=path/to/wheel.whl" && exit 1)
	twine upload \
		--repository-url http://localhost:$(PORT) \
		--skip-existing \
		$(WHEEL)
