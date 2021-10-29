#!/bin/bash
export PATH=$PATH:~/.local/bin

## PATCH?????????????????????????
cp -f ./dists/von/Dockerfile ./von/Dockerfile
cp -f ./dists/tails/Dockerfile.test ./tails/docker/Dockerfile.test
cp -f ./dists/von/Dockerfile.tails-server ./tails/docker/Dockerfile.tails-server

./von/manage build
./von/manage start

./tails/docker/manage build
./tails/docker/manage start
