#!/bin/bash

# IP container
CONTAINER_IP="10.0.3.167"

# Aktifkan IP Forwarding
echo "Aktifkan IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Daftar port TCP dan UDP
PORTS_TCP=(80 81 86 443 8080 51443 58080 40000 666 1723)
PORTS_UDP=(500 1701)

# NAT Masquerading
echo "Setting NAT Masquerade untuk $CONTAINER_IP..."
iptables -t nat -A POSTROUTING -s ${CONTAINER_IP%.*}.0/24 -j MASQUERADE

# Forward port TCP
echo "Forwarding port TCP..."
for port in "${PORTS_TCP[@]}"; do
    echo " - Port TCP $port"
    iptables -t nat -A PREROUTING -p tcp --dport $port -j DNAT --to $CONTAINER_IP:$port
done

# Forward port UDP
echo "Forwarding port UDP..."
for port in "${PORTS_UDP[@]}"; do
    echo " - Port UDP $port"
    iptables -t nat -A PREROUTING -p udp --dport $port -j DNAT --to $CONTAINER_IP:$port
done

# GRE protocol (untuk PPTP VPN)
echo "Mengizinkan GRE protocol (PPTP VPN)..."
iptables -A FORWARD -p gre -d $CONTAINER_IP -j ACCEPT

echo "Semua port forwarding berhasil diset!"
