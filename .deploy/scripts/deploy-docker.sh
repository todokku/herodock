#!/bin/sh

echo "$DOCKER_API_KEY" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker images;
docker push $DOCKER_USERNAME/$HEROKU_APP_NAME:$TRAVIS_TAG;