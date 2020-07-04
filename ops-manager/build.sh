#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD
# API_TOKEN

# set -ex

build() {

  echo docker build --no-cache --build-arg OPS_MGR_VERSION=${VERSION} --build-arg OPS_MGR_TAG=${TAG} -t ${image}:${tag} .
  docker build --no-cache --build-arg OPS_MGR_VERSION=${VERSION} --build-arg OPS_MGR_TAG=${TAG} -t ${image}:${tag} .

  if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == false ]]; then
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker push ${image}:${tag}
  fi
}

image="ubuntulinux/mongo-opsmgr"

echo $TAG
echo $VERSION

for tag in ${TAG}
do
  echo $tag
  status=$(curl -sL https://hub.docker.com/v2/repositories/${image}/tags/${tag})
  echo $status
  if [[ "${status}" =~ "not found" ]]; then
    build
  fi
done
