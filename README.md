# install
## 🚀 TAMPILAN MENU

Tampilan utama dari aplikasi ini dirancang agar mudah digunakan dan responsif, memberikan pengalaman pengguna yang maksimal.

<p align="center">
  <img src="https://github.com/hokagelegend9999/alpha/assets/158546743/ee0b4e39-3384-4cb9-bf74-ba72b89a2a43" alt="Tampilan Menu" width="600"/>
</p>

---



### DEPENDENSI 
```
sudo apt install dnsutils cron python3 gcc make build-essential zip unzip wget curl screen libz-dev g++ libreadline-dev libreadline-dev zlib1g-dev libssl-dev dos2unix cron vnstat mc jq bzip2 gzip vnstat coreutils rsyslog iftop git apt-transport-https build-essential earlyoom htop iptables jq python2 ruby cmake coreutils rsyslog net-tools nano sed gnupg gnupg1 bc jq dirmngr libxml-parser-perl lsof libsqlite3-dev python3-pip -y && python3 -m pip install --upgrade pip &&  python3 -m pip install tabulate && wget https://github.com/fians-xd/mmk/raw/refs/heads/main/shc.zip && unzip shc.zip && cd shc && sudo chmod +x * && sudo ./configure && sudo make && sudo make install && cd && rm -rf shc.zip shc
```

### INSTALL SCRIPT 
```
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/premi.sh && chmod +x premi.sh && ./premi.sh
```

## UPDATE SCRIPT
```
wget -q https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/update.sh && chmod +x update.sh && ./update.sh
```

### SUPPORT OS LINUX
- UBUNTU 20.04.05
- DEBIAN 10

### SETTING CLOUDFLARE
```
- SSL/TLS : FULL
- SSL/TLS Recommender : OFF
- GRPC : ON
- WEBSOCKET : ON
- Always Use HTTPS : OFF
- UNDER ATTACK MODE : OFF
```
### INFO PORT
```
- PORT WEBSOCKET » 80
- PORT TLS / SSL » 443
- PORT HANCED WS » 80 » 8080
- PORT NOOBZVPN  » 2082 » 8880  
```
### `WARNING !`
```
Jika Mendapatkan Status Service Off
Silahkan Restart Service.
Jika Statsus Service Masih Off
Silahkan Reboot vps kalian
```




### mendapatkan akses root ke vps mu

``````

  wget -qO- -O aksesroot.sh https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/aksesroot.sh && bash aksesroot.sh

```````


#### install debian 11


```
apt update -y && apt install wget -y
wget https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/premi_fixed_debian11.sh
chmod +x premi_fixed_debian11.sh
./premi_fixed_debian11.sh

```



#### INSTALL ULANG VPS UBUNTU DEBIAN

```
curl -O https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/reinstall.sh
chmod +x reinstall.sh
bash reinstall.sh debian 11 --password PASSWORD_KAMU

```
INSTALL HAPROXY DEBIAN 11

sudo apt install -t bullseye-backports haproxy
sed -i "s#xxx#https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/#g" /etc/haproxy/haproxy.cfg
sudo systemctl restart haproxy
sudo systemctl status haproxy


### MENU TAMBAHAN ( OPSIONAL)

- VPN ( SSTP + PPTP + L2TP )
- PENAMBAHAN NOTIF DLETE AKUN VMESS
- PENAMBAHAN PENGAHPUSAN CHACCE YANG MENUMPUK

```
wget https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/vpn_update_alphav2 && chmod +x vpn_update_alphav2 && ./vpn_update_alphav2
```


1. Aktifkan IP Forwarding di server VPS (Ubuntu 20)
Edit /etc/sysctl.conf, pastikan ada baris ini tidak dikomen (hapus tanda # jika ada):

bash
Copy
Edit
net.ipv4.ip_forward=1
Kemudian jalankan perintah ini untuk apply:

bash
Copy
Edit
sudo sysctl -p
2. Setup NAT dengan iptables (Supaya paket dari VPN client bisa keluar ke internet)
Misal interface internet kamu adalah eth0 (lihat di ip a):

bash
Copy
Edit
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
Lalu tambahkan aturan forward agar trafik dari VPN bisa diterima:

bash
Copy
Edit
sudo iptables -A FORWARD -i ppp+ -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o ppp+ -m state --state RELATED,ESTABLISHED -j ACCEPT
ppp+ adalah interface yang dipakai PPTP (dynamic ppp interface).

3. Simpan aturan iptables agar tetap aktif setelah reboot
Install paket iptables-persistent:

bash
Copy
Edit
sudo apt-get install iptables-persistent
sudo netfilter-persistent save
4. Pastikan konfigurasi PPTP daemon /etc/ppp/options dan /etc/ppp/pptpd-options
Biasanya sudah default benar, tapi kamu bisa cek dan pastikan ada:

Di /etc/ppp/options:

Copy
Edit
ms-dns 8.8.8.8
ms-dns 8.8.4.4


## SPESIAL ALL OS UBUNTU - DEBIAN -----
```
-------- lxc exec legacy-script-env -- bash ------
