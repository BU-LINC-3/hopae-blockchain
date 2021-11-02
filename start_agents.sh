#!/bin/bash
export PATH=$PATH:~/.local/bin
export ARIES_PATH=~/hopae-blockchain/aries
export HOST_IP=$(docker run --rm --net=host eclipse/che-ip)

docker build -q -t faber-alice-demo -f $ARIES_PATH/docker/Dockerfile.demo $ARIES_PATH
#LEDGER_URL=http://$HOST_IP:9000 ./aries/demo/run_demo faber --events --bg --revocation --tails-server-base-url http://$HOST_IP:6543
docker run --name team-3-issifier --rm -it -d -v /etc/localtime:/etc/localtime --network=bridge -p 8021:8021 -p 8020-8027:8020-8027 -v $ARIES_PATH/demo/../logs:/home/indy/logs -e LOG_LEVEL= -e RUNMODE=docker -e DOCKERHOST=$HOST_IP -e AGENT_PORT=8020 -e LEDGER_URL=http://$HOST_IP:9000 -e GENESIS_URL=http://$HOST_IP:9000/genesis -e EVENTS=1 -e TRACE_TARGET=log -e TRACE_TAG=acapy.events -e TRACE_ENABLED= faber-alice-demo faber --port 8020 --revocation --tails-server-base-url http://$HOST_IP:6543
sleep 10
#LEDGER_URL=http://$HOST_IP:9000 ./aries/demo/run_demo alice --events --bg 
docker run --name team-3-agent --rm -it -d -v /etc/localtime:/etc/localtime --network=bridge -p 8031:8031 -p 8030-8037:8030-8037 -v $ARIES_PATH/demo/../logs:/home/indy/logs -e LOG_LEVEL= -e RUNMODE=docker -e DOCKERHOST=$HOST_IP -e AGENT_PORT=8030 -e LEDGER_URL=http://$HOST_IP:9000 -e GENESIS_URL=http://$HOST_IP:9000/genesis -e EVENTS=1 -e TRACE_TARGET=log -e TRACE_TAG=acapy.events -e TRACE_ENABLED= faber-alice-demo alice --port 8030
