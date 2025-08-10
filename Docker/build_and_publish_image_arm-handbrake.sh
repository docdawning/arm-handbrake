#!/bin/bash
IMAGE_NAME="docdawning/arm-handbrake"
TAG="latest"

echo "Building Docker image ${IMAGE_NAME}:${TAG}..."
docker build -t "${IMAGE_NAME}:${TAG}" .

echo "Logging in to Docker Hub..."
docker login

echo "Pushing image ${IMAGE_NAME}:${TAG} to Docker Hub..."
docker push "${IMAGE_NAME}:${TAG}"

echo "Done."

