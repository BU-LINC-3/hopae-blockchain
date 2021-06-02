#!/bin/bash
export PATH=$PATH:~/.local/bin
export ARIES_PATH=/opt/team3/aries

docker build -q -t faber-alice-demo -f $ARIES_PATH/docker/Dockerfile.demo $ARIES_PATH
#LEDGER_URL=http://127.0.0.1:9000 PUBLIC_TAILS_URL=http://127.0.0.1 ./aries/demo/run_demo faber --events --bg
docker run --name team-3-issifier --rm -it -d --network=bridge -p 1061:8021 -p 8020-8027:8020-8027 -v $ARIES_PATH/demo/../logs:/home/indy/logs -e LOG_LEVEL= -e RUNMODE=docker -e DOCKERHOST=172.17.0.1 -e AGENT_PORT=8020 -e LEDGER_URL=http://172.18.0.1:9000 -e GENESIS_URL=http://172.18.0.1:9000/genesis -e EVENTS=1 -e TRACE_TARGET=log -e TRACE_TAG=acapy.events -e TRACE_ENABLED= faber-alice-demo faber --port 8020 --revocation --tails-server-base-url http://172.18.0.1:6543
sleep 10
#LEDGER_URL=http://127.0.0.1:9000 ./aries/demo/run_demo alice --events --bg
docker run --name team-3-agent --rm -it -d --network=bridge -p 1062:8031 -p 8030-8037:8030-8037 -v $ARIES_PATH/demo/../logs:/home/indy/logs -e LOG_LEVEL= -e RUNMODE=docker -e DOCKERHOST=172.17.0.1 -e AGENT_PORT=8030 -e LEDGER_URL=http://172.18.0.1:9000 -e GENESIS_URL=http://172.18.0.1:9000/genesis -e EVENTS=1 -e TRACE_TARGET=log -e TRACE_TAG=acapy.events -e TRACE_ENABLED= faber-alice-demo alice --port 8030
