#!/bin/sh

if [ -f "/usr/bin/frps" ]; then
    frps -c /etc/frp/frps.toml
else
    frpc -c /etc/frp/frpc.toml
fi
