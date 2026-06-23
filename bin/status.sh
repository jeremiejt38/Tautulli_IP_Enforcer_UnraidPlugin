#!/bin/bash
PLUGIN_DIR="/boot/config/plugins/tautulli-ip-enforcer"
PIDFILE="${PLUGIN_DIR}/tautulliipenforcer.pid"
LOGFILE="${PLUGIN_DIR}/tautulliipenforcer.log"

if [ -f "$PIDFILE" ]; then
  PID=$(cat "$PIDFILE")
  if kill -0 "$PID" >/dev/null 2>&1; then
    echo "Active - PID $PID"
    exit 0
  else
    echo "Stale pidfile (process $PID not running)"
    exit 2
  fi
else
  echo "Inactive"
  exit 1
fi
