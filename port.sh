#!/bin/bash

CONTAINER="legacy-script-env"
CONTAINER_IP="10.104.225.79"

# Fungsi menambahkan forwarding port
add_forward() {
    NAME=$1
    HOST_PORT=$2
    CONTAINER_PORT=$3
    PROTOCOL=${4:-tcp}

    echo "Menambahkan port forward: $NAME ($PROTOCOL $HOST_PORT → $CONTAINER_IP:$CONTAINER_PORT)"
    lxc config device add "$CONTAINER" "$NAME" proxy \
        listen=$PROTOCOL:0.0.0.0:$HOST_PORT \
        connect=$PROTOCOL:$CONTAINER_IP:$CONTAINER_PORT \
        bind=host || echo "⚠️  $NAME sudah ada, dilewati."
}

echo "=== Menambahkan semua port forwarding ke container: $CONTAINER ==="

# Web Ports
add_forward "http" 80 80
add_forward "https" 443 443

# SSH & SSH over WebSocket
add_forward "sshws2082" 2082 2082
add_forward "sshws2086" 2086 2086

# Xray / VMess / VLESS / Trojan (contoh port populer)
add_forward "xrayv443" 444 443
add_forward "xrayv8443" 8443 8443
add_forward "xrayv8080" 8080 8080
add_forward "xrayv8880" 8880 80

# Dropbear SSH (umumnya 44 / 143)
add_forward "dropbear44" 44 44
add_forward "dropbear143" 143 143

# HAProxy
add_forward "haproxy8081" 8081 8081

# VPN Ports
add_forward "sstp" 4443 443
add_forward "pptp" 1723 1723
add_forward "l2tp" 1701 1701 udp

# Tambahan umum lainnya
add_forward "openvpn1194" 1194 1194 udp
add_forward "squid3128" 3128 3128

echo "✅ Semua port forwarding selesai ditambahkan!"
