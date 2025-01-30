.PHONY: all image image-from-scratch

all: image

##########
# no TeX #
##########

image:
	DOCKER_BUILDKIT=1 \
		docker build \
			-t bstguy/env \
				docker

image-from-scratch:
	DOCKER_BUILDKIT=1 \
		docker build \
			-t bstguy/env \
			--no-cache \
				docker

push: image
	docker push bstguy/env

push-from-scratch: image-from-scratch
	docker push bstguy/env

push-only:
	docker push bstguy/env

#######
# TeX #
#######

tex-image:
	DOCKER_BUILDKIT=1 \
		docker build \
			--build-arg WITH_TEX=true \
			-t bstguy/env-tex \
				docker

tex-image-from-scratch:
	DOCKER_BUILDKIT=1 \
		docker build \
			--build-arg WITH_TEX=true \
			-t bstguy/env-tex \
			--no-cache \
				docker

tex-push: tex-image
	docker push bstguy/env-tex

tex-push-from-scratch: tex-image-from-scratch
	docker push bstguy/env-tex

tex-push-only:
	docker push bstguy/env-tex

help:
	grep '^[a-zA-Z\-_0-9].*:' Makefile | cut -d : -f 1 | sort
