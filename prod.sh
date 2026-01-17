#!/bin/bash
## check if docker is running and installed
if ! docker info > /dev/null 2>&1; then
  echo "Docker is not running or not installed. Please start Docker and try again."
  exit 1
fi

echo "Cloning git projects if not already cloned..."

./git-clone-projects.sh
if [ $? -ne 0 ]; then
  echo "Failed to clone git projects. Exiting."
  exit 1
fi

echo "Building and starting Docker containers..."
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build --wait
