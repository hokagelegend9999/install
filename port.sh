#!/bin/bash
# ================================================
# AUTO PORT FORWARDING SCRIPT FOR LXC CONTAINER
# ================================================

# Hentikan script jika ada error
set -e

# --- [1] Dapatkan nama container dan IP ---
CONTAINER_NAME=$(lxc list -c n --format csv | head -1)
CONTAINER_IP=$(lxc list -c 4 --format csv | awk -F' ' '{print $1}' | head -1)

# Verifikasi container ditemukan
if [ -z "$CONTAINER_NAME" ] || [ -z "$CONTAINER_IP" ]; then
    echo "❌ Error: Tidak ada container yang berjalan atau IP tidak ditemukan"
    lxc list
    exit 1
fi

echo "🔍 Container ditemukan:"
echo "Nama: $CONTAINER_NAME"
echo "IP: $CONTAINER_IP"

# --- [2] Buat profile khusus ---
echo "🛠️ Membuat profile tunneling..."
lxc profile create tunneling 2>/dev/null || true

# --- [3] Fungsi untuk menambahkan port forwarding ---
add_port() {
    local port_name=$1
    local external_port=$2
    local internal_port=$3
    local protocol=${4:-tcp}
    
    echo "🔹 Forwarding $protocol port $external_port -> $CONTAINER_IP:$internal_port ($port_name)"
    lxc profile device add tunneling "$port_name" proxy \
        listen=$protocol:0.0.0.0:$external_port \
        connect=$protocol:$CONTAINER_IP:$internal_port
}

# --- [4] SSH ---
add_port ssh1 22 22
add_port ssh2 222 222
add_port ssh3 444 444

# --- [5] Dropbear ---
add_port dropbear1 443 443
add_port dropbear2 445 445

# --- [6] Websocket/Xray ---
add_port ws1 80 80
add_port ws2 443 443
add_port ws3 8080 8080

# --- [7] HAProxy ---
add_port haproxy1 80 80
add_port haproxy2 443 443

# --- [8] SSTP ---
add_port sstp 5555 5555

# --- [9] PPTP ---
add_port pptp 1723 1723

# --- [10] L2TP ---
add_port l2tp1 1701 1701 udp
add_port l2tp2 500 500 udp
add_port l2tp3 4500 4500 udp

# --- [11] Terapkan ke container ---
echo "📌 Menerapkan profile ke container..."
lxc profile add "$CONTAINER_NAME" tunneling

# --- [12] Selesai ---
cat <<EOF

✅ PORT FORWARDING BERHASIL DIBUAT UNTUK CONTAINER:
   Nama: $CONTAINER_NAME
   IP: $CONTAINER_IP

🔹 SSH: 22, 222, 444
🔹 Dropbear: 443, 445
🔹 Websocket/Xray: 80, 443, 8080
🔹 HAProxy: 80, 443
🔹 SSTP: 5555
🔹 PPTP: 1723
🔹 L2TP: 1701/udp, 500/udp, 4500/udp

🔥 Tips:
- Untuk cek port yang aktif:
  lxc config device show $CONTAINER_NAME
- Untuk menghapus forwarding:
  lxc profile remove $CONTAINER_NAME tunneling
EOF
