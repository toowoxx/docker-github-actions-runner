#!/bin/bash -e

docker build -t toowoxx/github-actions-runner:$1 -f Dockerfile .
docker tag toowoxx/github-actions-runner:$1 toowoxx/github-actions-runner:latest

docker build -t toowoxx/github-actions-runner:$1-full -f full.Dockerfile .
docker tag toowoxx/github-actions-runner:$1-full toowoxx/github-actions-runner:latest-full

docker push toowoxx/github-actions-runner:latest
docker push toowoxx/github-actions-runner:latest-full
docker push toowoxx/github-actions-runner:$1
docker push toowoxx/github-actions-runner:$1-full

