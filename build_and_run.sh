#!/bin/bash

VERSION_FILE="version.txt"

if [ ! -f $VERSION_FILE ]; then
    echo "1" > $VERSION_FILE
fi

VERSION=$(cat $VERSION_FILE)

NEW_VERSION=$((VERSION + 1))

echo $NEW_VERSION > $VERSION_FILE

export VERSION=$NEW_VERSION

docker-compose build

if docker image inspect mohamed-devops-flask:$NEW_VERSION > /dev/null 2>&1; then
    echo "Image built and tagged as: mohamed-devops-flask:$NEW_VERSION"
    docker compose up
else
    echo "Error: Failed to build the image mohamed-devops-flask:$NEW_VERSION"
    exit 1
fi
