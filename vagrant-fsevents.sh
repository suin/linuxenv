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
    [ -f vagrant-fsevents.pid ] || exit
    PID=$(cat vagrant-fsevents.pid)
    ps -p ${PID} > /dev/null && {
      for CPID in $(pgrep -P ${PID})
      do
        kill -15 ${CPID}
      done
      kill -15 ${PID}
    }
    rm vagrant-fsevents.pid
    ;;
esac
