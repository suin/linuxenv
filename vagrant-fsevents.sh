#!/usr/bin/env bash
set -eu

subcommand="$1"
shift

case ${subcommand} in
  start)
    vagrant fsevents &
    PID=$!
    echo ${PID} > vagrant-fsevents.pid
    ;;
  stop)
    [ -f vagrant-fsevents.pid ] || break
    PID=$(cat vagrant-fsevents.pid)
    ps -p ${PID} > /dev/null && kill ${PID}
    rm vagrant-fsevents.pid
    ;;
esac
