#!/bin/bash

WORKDIR="/data/_work"

if [ ! -f "$WORKDIR/.configured" ]; then
  ./config.sh --work "$WORKDIR" $CONFIG_PARAMS
  touch $WORKDIR/.configured
fi

./run.sh

