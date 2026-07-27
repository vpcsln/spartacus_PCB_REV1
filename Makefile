KICAD_IMAGE := kicad/kicad:10.0.5
CONTAINER_ENGINE ?= docker

.PHONY: verify verify-container

verify:
	./scripts/verify-project.sh

verify-container:
	$(CONTAINER_ENGINE) run --rm \
		--user "$$(id -u):$$(id -g)" \
		--env HOME=/tmp \
		--volume "$(CURDIR):/workspace" \
		--workdir /workspace \
		--entrypoint /bin/sh \
		$(KICAD_IMAGE) \
		-c ./scripts/verify-project.sh
