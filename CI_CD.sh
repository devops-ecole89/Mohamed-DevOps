#!/bin/bash
# Stop the script if any command fails
set -e

# Variables
DOCKER_IMAGE_NAME="flask"

echo "Constructing the Docker image named $DOCKER_IMAGE_NAME..."
docker build -t $DOCKER_IMAGE_NAME .

echo "Executing the tests"
docker run $DOCKER_IMAGE_NAME python -m pytest tests/
docker logs $DOCKER_IMAGE_NAME

echo $?
TEST_STATUS=$?

if [ $TEST_STATUS -eq 0 ]; then
    echo "Tests passed successfully"

else
    echo "Tests failed"
    exit 1
fi