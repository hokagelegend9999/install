#!/bin/bash

CONTAINER_NAME="vpn-container"

echo "📦 Menambahkan port forwarding ke container: $CONTAINER_NAME"

# === XRAY ===
lxc config device add $CONTAINER_NAME xray443 proxy listen=tcp:0.0.0.0:443 connect=tcp:127.0.0.1:443
lxc config device add $CONTAINER_NAME xray80 proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
lxc config device add $CONTAINER_NAME xray10000 proxy listen=tcp:0.0.0.0:10000 connect=tcp:127.0.0.1:10000

# === SSH WebSocket ===
lxc config device add $CONTAINER_NAME sshws8880 proxy listen=tcp:0.0.0.0:8880 connect=tcp:127.0.0.1:8880
lxc config device add $CONTAINER_NAME sshws2082 proxy listen=tcp:0.0.0.0:2082 connect=tcp:127.0.0.1:2082
lxc config device add $CONTAINER_NAME sshws8080 proxy listen=tcp:0.0.0.0:8080 connect=tcp:127.0.0.1:8080

# === Dropbear ===
lxc config device add $CONTAINER_NAME dropbear22 proxy listen=tcp:0.0.0.0:149 connect=tcp:127.0.0.1:149
lxc config device add $CONTAINER_NAME dropbear109 proxy listen=tcp:0.0.0.0:109 connect=tcp:127.0.0.1:109
lxc config device add $CONTAINER_NAME dropbear143 proxy listen=tcp:0.0.0.0:143 connect=tcp:127.0.0.1:143
lxc config device add $CONTAINER_NAME dropbear442 proxy listen=tcp:0.0.0.0:442 connect=tcp:127.0.0.1:442

# === HAProxy ===
lxc config device add $CONTAINER_NAME haproxy8443 proxy listen=tcp:0.0.0.0:8443 connect=tcp:127.0.0.1:8443
lxc config device add $CONTAINER_NAME haproxy8080 proxy listen=tcp:0.0.0.0:8080 connect=tcp:127.0.0.1:8080
lxc config device add $CONTAINER_NAME haproxy3000 proxy listen=tcp:0.0.0.0:3000 connect=tcp:127.0.0.1:3000

echo "✅ Semua port forwarding berhasil ditambahkan."
