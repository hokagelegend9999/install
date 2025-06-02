#!/bin/bash
# ================================================
# PORT FORWARDING UNTUK MULTIPLE SERVICE
# ================================================
CONTAINER_NAME="legacy-script-env"

# --- [1] HENTIKAN SERVICE YANG MENGGUNAKAN PORT ---
echo "🛑 Menghentikan service yang menggunakan port terkait..."
sudo systemctl stop nginx apache2 lighttpd 2>/dev/null
sudo kill $(sudo lsof -t -i:80 -i:443 -i:2222 -i:2082 -i:2223 -i:5555 -i:1701 -i:1723) 2>/dev/null

# --- [2] HAPUS PORT FORWARDING LAMA ---
echo "🧹 Membersihkan port forwarding lama..."
for device in http https ssh sshws dropbear sstp l2tp pptp haproxy-http haproxy-https
do
    lxc config device remove $CONTAINER_NAME $device 2>/dev/null
done

# --- [3] SETUP PORT FORWARDING BARU ---
echo "🔌 Membuat port forwarding baru..."

# SSH Standar (Host:2222 -> Container:22)
lxc config device add $CONTAINER_NAME ssh proxy \
  listen=tcp:0.0.0.0:2222 connect=tcp:127.0.0.1:22

# SSH WebSocket (Host:2082 -> Container:2082)
lxc config device add $CONTAINER_NAME sshws proxy \
  listen=tcp:0.0.0.0:2082 connect=tcp:127.0.0.1:2082

# Dropbear (Host:2223 -> Container:2223)
lxc config device add $CONTAINER_NAME dropbear proxy \
  listen=tcp:0.0.0.0:2223 connect=tcp:127.0.0.1:2223

# SSTP (Host:5555 -> Container:5555)
lxc config device add $CONTAINER_NAME sstp proxy \
  listen=tcp:0.0.0.0:5555 connect=tcp:127.0.0.1:5555

# PPTP (Host:1723 -> Container:1723)
lxc config device add $CONTAINER_NAME pptp proxy \
  listen=tcp:0.0.0.0:1723 connect=tcp:127.0.0.1:1723

# L2TP (UDP 1701)
lxc config device add $CONTAINER_NAME l2tp proxy \
  listen=udp:0.0.0.0:1701 connect=udp:127.0.0.1:1701

# HAProxy HTTP (Host:80 -> Container:80)
lxc config device add $CONTAINER_NAME haproxy-http proxy \
  listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80

# HAProxy HTTPS (Host:443 -> Container:443)
lxc config device add $CONTAINER_NAME haproxy-https proxy \
  listen=tcp:0.0.0.0:443 connect=tcp:127.0.0.1:443

# --- [4] KONFIGURASI FIREWALL ---
echo "🔥 Membuka port di firewall..."
sudo ufw allow 2222/tcp
sudo ufw allow 2082/tcp
sudo ufw allow 2223/tcp
sudo ufw allow 5555/tcp
sudo ufw allow 1723/tcp
sudo ufw allow 1701/udp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# --- [5] VERIFIKASI ---
echo "✅ Port forwarding berhasil diatur:"
echo "-----------------------------------"
echo "Service          | Port Host | Port Container"
echo "-----------------------------------"
echo "SSH Standar      | 2222      | 22"
echo "SSH WebSocket    | 2082      | 2082"
echo "Dropbear         | 2223      | 2223"
echo "SSTP             | 5555      | 5555"
echo "PPTP             | 1723      | 1723"
echo "L2TP             | 1701/udp  | 1701/udp"
echo "HAProxy (HTTP)   | 80        | 80"
echo "HAProxy (HTTPS)  | 443       | 443"
echo "-----------------------------------"
echo ""
echo "📌 Pastikan service berikut sudah berjalan di container:"
echo "   - SSH WebSocket (port 2082)"
echo "   - Dropbear (port 2223)"
echo "   - HAProxy (port 80/443)"
echo "   - SSTP (port 5555)"
echo "   - L2TP (port 1701/udp)"
echo "   - PPTP (port 1723)"
