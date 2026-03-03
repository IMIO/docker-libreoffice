#!/bin/bash
set -e

if [ "${OFFLINE}" = "true" ]; then
    sed -i 's/^hosts:.*/hosts:          files/' /etc/nsswitch.conf
fi

exec gosu imio "$@"
