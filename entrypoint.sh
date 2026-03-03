#!/bin/bash
set -e

if [ "${OFFLINE}" = "true" ]; then
    echo "OFFLINE mode: disabling external DNS lookups"
    sed -i 's/^hosts:.*/hosts:          files/' /etc/nsswitch.conf
fi

exec gosu imio "$@"
