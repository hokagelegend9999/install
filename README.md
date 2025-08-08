# install ALL OS UBUNTU 


1. UNTUK UBUNTU 24
   INSTALL VIRTUAL MACHINE LXD
```
cd root
rm virtual
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/virtual && chmod +x virtual && ./virtual
cd root
rm virtual
```

2. BUKA PORT
   
```
   cd
rm port.sh
wget -q https://github.com/Ilham24022001/ganteng/raw/refs/heads/main/port.sh && chmod +x port.sh && ./port.sh
cd
rm port.sh
```

3.  NTUK DEBIAN 12

```
cd root
rm virtual_debian12
apt install -y && apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/virtual_debian12 && chmod +x virtual_debian12 && ./virtual_debian12
cd root
rm virtual_debian12
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
wget -q https://github.com/hokagelegend9999/install/raw/refs/heads/main/update_alphav2 && chmod +x update_alphav2 && ./update_alphav2
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
apt install -y && apt update -y && apt upgrade -y && wget -q https://github.com/hokagelegend9999/install/raw/refs/heads/main/coklat && chmod +x coklat && ./coklat
```


### SUPPORT OS LINUX
- UBUNTU 20.04.05
- DEBIAN 10


### UPDATE SCRIPT

```
cd root
rm update_coklat
 wget https://github.com/hokagelegend9999/install/raw/refs/heads/main/update_coklat && chmod +x update_coklat && ./update_coklat
cd root
rm update_coklat

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

-------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------


# INSTALLASI AUTO SCRYPT LITE2

```
apt update && apt upgrade -y && apt install -y wget screen && wget -q https://raw.githubusercontent.com/hokagelegend9999/lite2/main/setup.sh && chmod +x setup.sh && screen -S setup ./setup.sh
```

## SUPPORT OS  
  
➽ Debian 10 & 11 (recommended)   
➽ Ubuntu 20.04   
--------------------------------------------------------------------------------------------------------------------------------------------------



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
===========================================================================================================================================


### BEFORE INSTALL OS UBUNTU  22 & 24 GENOM
1.

```
apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub 
```

2.

```
 apt install curl jq wget screen build-essential -y && reboot
```

### INSTALL SCRIPT 


<pre><code> wget -q https://raw.githubusercontent.com/hokagelegend9999/install/refs/heads/main/Genom_v1 && chmod +x Genom_v1  && ./Genom_v1 
</code></pre>


## 2. UPDATE 

```
cd root
rm update.sh
wget https://github.com/hokagelegend9999/genom/raw/refs/heads/main/menu/update.sh && chmod +x update.sh && ./update.sh
```




# INSTALL LITE SUPER UBUNTU 24 TERBARU

```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://github.com/hokagelegend9999/install/raw/refs/heads/main/Lite-Super && chmod +x Lite-Super && sed -i -e 's/\r$//' Lite-Super && screen -S setup ./Lite-Super
```

# INSTALL SCRIPT FORCE

```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://github.com/hokagelegend9999/install/raw/refs/heads/main/force && chmod +x force && sed -i -e 's/\r$//' force && screen -S setup ./force
```
