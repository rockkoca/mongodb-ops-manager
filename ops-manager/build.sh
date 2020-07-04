#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD
# API_TOKEN

# set -ex

build() {

  echo docker build --no-cache --build-arg OPSMGR_VERSION=${VERSION} --build-arg OPSMGR_TAG-${TAg} -t ${image}:${tag} .
  docker build --no-cache --build-arg OPSMGR_VERSION=${VERSION} --build-arg OPSMGR_TAG-${TAg} -t ${image}:${tag} .

  if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == false ]]; then
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker push ${image}:${tag}
  fi
}

image="ubuntulinux/mongo-opsmgr"

echo $TAG
echo $VERSION

tag=${TAG}

build
