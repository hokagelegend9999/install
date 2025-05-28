# install ALL OS UBUNTU 


1. INSTALL VIRTUAL MACHINE LXD
```
cd root
rm virtual
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/virtual && chmod +x virtual && ./virtual
cd root
rm virtual
```
1. jALANKAN SCRIPT VIRTUAL
```
lxc exec legacy-script-env -- bash
```

1.  INSTALL SCRIPT TERSEBUT SETELAH UPDATE & UPGRADE
2. MASUK DENGAN "menu"
3. LALU UPDATE DAN UPGRADE KEMBALI
4.  JALANKAN INSTALLER
5. KELUAR DENGAN " exit "
SELESAI

  ### MENGHAPUS LXD INSTALL ULANG
   
   ```
cd root
rm install_ulang_virtual
   wget -q https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/install_ulang_virtual && chmod +x install_ulang_virtual && ./install_ulang_virtual
cd root
rm install_ulang_virtual
   ```
## 🚀 ALPHA SCRIPT

Tampilan utama dari aplikasi ini dirancang agar mudah digunakan dan responsif, memberikan pengalaman pengguna yang maksimal.


### INSTALL SCRIPT 

```
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/alphav2 && chmod +x alphav2 && ./alphav2
```

## UPDATE SCRIPT
```
wget -q https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/update.sh && chmod +x update.sh && ./update.sh
```

### SUPPORT OS LINUX
- UBUNTU 20.04.05
- DEBIAN 10


### mendapatkan akses root ke vps mu

``````

  wget -qO- -O aksesroot.sh https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/aksesroot.sh && bash aksesroot.sh

```````


#### INSTALL ULANG VPS UBUNTU DEBIAN

```
curl -O https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/reinstall.sh
chmod +x reinstall.sh
bash reinstall.sh debian 11 --password PASSWORD_KAMU

```
INSTALL HAPROXY DEBIAN 11

```
sudo apt install -t bullseye-backports haproxy
sed -i "s#xxx#https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/#g" /etc/haproxy/haproxy.cfg
sudo systemctl restart haproxy
sudo systemctl status haproxy
```

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

```
sudo iptables -A FORWARD -i ppp+ -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o ppp+ -m state --state RELATED,ESTABLISHED -j ACCEPT
ppp+ adalah interface yang dipakai PPTP (dynamic ppp interface).
```
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


## SPESIAL ALL OS UBUNTU - DEBIAN 

-  lxc exec legacy-script-env -- bash 


-----------------------------------------------------------------------------------------------------------------------
#  COKLAT INSTALLASI

### CARA INSTALASI :     

1.  :    
<pre><code>apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub</code></pre>

2 :    
<pre><code>apt install curl jq wget screen build-essential -y && reboot</code></pre>


### INSTALL SCRIPT 

```
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/hokagelegend9999/coklat/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh
```


### SUPPORT OS LINUX
- UBUNTU 20.04.05
- DEBIAN 10


### UPDATE SCRIPT

```

 wget https://github.com/hokagelegend9999/coklat/raw/refs/heads/main/update.sh && chmod +x update.sh && ./update.sh

```
---------------------------------------------------------------------------------------------------------------------------------------------

#  HUMBLE INSTALLASI

### CARA INSTALASI :     

1.  :    
<pre><code>apt-get update && apt-get upgrade -y && apt install grub2-common && apt dist-upgrade -y </code></pre>

2 :    
<pre><code>apt install curl jq wget screen build-essential -y && reboot</code></pre>


### INSTALL SCRIPT 

```
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/humble && chmod +x humble && ./humble
```

3 : UPDATE SCRIPT HUMBLE

```
wget -q  https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/update_humble &&  chmod +x update_humble && ./update_humble
```

---------------------------------------------------------------------------------------


## - Update Auto Reboot jam 12 Malam
## - Update Maximal IP User & IP Unlimited

  
## setelah REBOOT pakai port di bawah ini :

- Port 500
- Port 40000
- Port 81
- Port51443
- Port 58080
- Port 666

# INSTALLASI AUTO SCRYPT LITE2

```
apt update && apt upgrade -y && apt install -y wget screen && wget -q https://raw.githubusercontent.com/hokagelegend9999/lite2/main/setup.sh && chmod +x setup.sh && screen -S setup ./setup.sh

```
---------------------------------------------------------------------------

## SUPPORT OS  
  
➽ Debian 10 & 11 (recommended)   
➽ Ubuntu 20.04   

### INSTALASI SCRIPT GAS :     

1.  :    
<pre><code>apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub</code></pre>

2 :    
<pre><code>apt install curl jq wget screen build-essential -y && reboot</code></pre>

3:    
➽ Pastikan anda sudah login sebagai root :    
<pre><code>apt install tmux -y && wget -q https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/gas && chmod +x gas && tmux new-session -d -s hokagelegend './gas' && tmux attach -t hokagelegend</code></pre>

4 :     
➽ If during the installation connection was lost, login to the vps again and run the command ☞shell

<pre><code>tmux attach -t hokagelegend</code></pre>


-----------------------------------------------------------------------------------------------------



### BEFORE INSTALL
1.

```
apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub 
```

2.

```
 apt install curl jq wget screen build-essential -y && reboot
```

### INSTALL SCRIPT 


<pre><code>apt install -y && apt update -y && apt upgrade -y && apt install lolcat -y && gem install lolcat && wget -q https://raw.githubusercontent.com/hokagelegend9999/force/refs/heads/main/premi.sh && chmod +x premi.sh && ./premi.sh
</code></pre>



### TESTED ON OS 
- UBUNTU 20.04.05
- DEBIAN 10



