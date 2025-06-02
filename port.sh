#!/bin/bash
# ================================================
# PORT FORWARDING UNTUK:
# - SSH (22, 222, 444)
# - Dropbear (443, 445)
# - Websocket/Xray (80, 443, 8080)
# - HAProxy (80, 443)
# - SSTP (5555)
# - PPTP (1723)
# - L2TP (1701, 500, 4500)
# ================================================

# Hentikan script jika ada error
set -e

# --- [1] Buat profile khusus ---
lxc profile create tunneling 2>/dev/null || true

# --- [2] SSH ---
echo "🔹 Forwarding port SSH..."
lxc profile device add tunneling ssh1 proxy listen=tcp:0.0.0.0:22 connect=tcp:127.0.0.1:22
lxc profile device add tunneling ssh2 proxy listen=tcp:0.0.0.0:222 connect=tcp:127.0.0.1:222
lxc profile device add tunneling ssh3 proxy listen=tcp:0.0.0.0:444 connect=tcp:127.0.0.1:444

# --- [3] Dropbear ---
echo "🔹 Forwarding port Dropbear..."
lxc profile device add tunneling dropbear1 proxy listen=tcp:0.0.0.0:443 connect=tcp:127.0.0.1:443
lxc profile device add tunneling dropbear2 proxy listen=tcp:0.0.0.0:445 connect=tcp:127.0.0.1:445

# --- [4] Websocket/Xray ---
echo "🔹 Forwarding port Websocket/Xray..."
lxc profile device add tunneling ws1 proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
lxc profile device add tunneling ws2 proxy listen=tcp:0.0.0.0:443 connect=tcp:127.0.0.1:443
lxc profile device add tunneling ws3 proxy listen=tcp:0.0.0.0:8080 connect=tcp:127.0.0.1:8080

# --- [5] HAProxy ---
echo "🔹 Forwarding port HAProxy..."
lxc profile device add tunneling haproxy1 proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
lxc profile device add tunneling haproxy2 proxy listen=tcp:0.0.0.0:443 connect=tcp:127.0.0.1:443

# --- [6] SSTP ---
echo "🔹 Forwarding port SSTP..."
lxc profile device add tunneling sstp proxy listen=tcp:0.0.0.0:5555 connect=tcp:127.0.0.1:5555

# --- [7] PPTP ---
echo "🔹 Forwarding port PPTP..."
lxc profile device add tunneling pptp proxy listen=tcp:0.0.0.0:1723 connect=tcp:127.0.0.1:1723

# --- [8] L2TP ---
echo "🔹 Forwarding port L2TP..."
lxc profile device add tunneling l2tp1 proxy listen=udp:0.0.0.0:1701 connect=udp:127.0.0.1:1701
lxc profile device add tunneling l2tp2 proxy listen=udp:0.0.0.0:500 connect=udp:127.0.0.1:500
lxc profile device add tunneling l2tp3 proxy listen=udp:0.0.0.0:4500 connect=udp:127.0.0.1:4500

# --- [9] Terapkan ke container ---
lxc profile add ubuntu20 tunneling

# --- [10] Selesai ---
cat <<EOF

✅ PORT FORWARDING BERHASIL DIBUAT!

🔹 SSH: 22, 222, 444
🔹 Dropbear: 443, 445
🔹 Websocket/Xray: 80, 443, 8080
🔹 HAProxy: 80, 443
🔹 SSTP: 5555
🔹 PPTP: 1723
🔹 L2TP: 1701/udp, 500/udp, 4500/udp

🔥 Tips:
- Untuk cek port yang aktif:
  lxc config device show ubuntu20
- Jika ada konflik port, edit script dan sesuaikan
EOF
