#!/bin/env bash

DOCKER_IMAGE_NAME=niko-jira
DOCKER_IMAGE_VERSION=latest
alias 
podman  rmi --force=true ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}
podman  build --force-rm=true --rm=true -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} .
echo =========================================================================
echo Docker image is ready.  Try it out by running:
echo     podman run --rm -ti -P ${DOCKER_IMAGE_NAME}
echo =========================================================================


