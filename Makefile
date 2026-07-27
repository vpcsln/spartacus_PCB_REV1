KICAD_IMAGE := kicad/kicad:10.0.4@sha256:770e2fa006695077b5ba218742d5c3137896af91257b2ca971243fa56b01bb86
KICAD_CONTAINER_VERSION := 10.0.4
CONTAINER_ENGINE ?= docker

.PHONY: verify verify-container

verify:
	./scripts/verify-project.sh

verify-container:
	$(CONTAINER_ENGINE) run --rm \
		--user "$$(id -u):$$(id -g)" \
		--env HOME=/tmp \
		--env KICAD_EXPECTED_VERSION=$(KICAD_CONTAINER_VERSION) \
		--volume "$(CURDIR):/workspace" \
		--workdir /workspace \
		--entrypoint /bin/sh \
		$(KICAD_IMAGE) \
		-c ./scripts/verify-project.sh
