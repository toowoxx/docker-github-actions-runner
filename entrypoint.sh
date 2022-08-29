#!/bin/bash -e

WORKDIR="/data/_work"

if [ ! -f ".credentials" ]; then
  ./config.sh --work "$WORKDIR" $CONFIG_PARAMS
fi

./run.sh

