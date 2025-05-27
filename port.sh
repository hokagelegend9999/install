#!/bin/bash

CONTAINER="legacy-script-env"
CONTAINER_IP="10.103.208.20"

add_forward() {
    NAME=$1
    HOST_PORT=$2
    CONTAINER_PORT=$3
    PROTOCOL=${4:-tcp}

    echo "Menambahkan forward: $NAME (Host:$HOST_PORT → $CONTAINER_IP:$CONTAINER_PORT $PROTOCOL)"
    lxc config device add "$CONTAINER" "$NAME" proxy \
        listen=$PROTOCOL:0.0.0.0:$HOST_PORT \
        connect=$PROTOCOL:$CONTAINER_IP:$CONTAINER_PORT \
        bind=host
}

# SSH over WebSocket
add_forward "sshws80" 80 80
add_forward "sshws443" 443 443
add_forward "sshws2082" 2082 2082
add_forward "sshws2086" 2086 2086

# Xray (VMess/VLESS/Trojan - sesuaikan jika beda)
add_forward "xray444" 444 443
add_forward "xray8880" 8880 80
add_forward "xray8080" 8080 8080
add_forward "xray8443" 8443 8443

# HAProxy
add_forward "haproxy8081" 8081 8081

# VPN Services
add_forward "sstp" 4443 443
add_forward "pptp" 1723 1723
add_forward "l2tp" 1701 1701 udp

# Dropbear SSH
add_forward "dropbear44" 44 44
add_forward "dropbear143" 143 143

echo "✅ Port forwarding selesai."
