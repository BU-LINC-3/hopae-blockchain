#!/bin/bash
export PATH=$PATH:~/.local/bin

./von/manage build
./von/manage start

./tails/docker/manage build
./tails/docker/manage start
