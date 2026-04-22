#!/bin/bash

#GANTI PASSWORD DEFAULT
restart_system(){
    #IZIN SCRIPT
    curl "ipinfo.io/org?token=7a814b6263b02c" > /root/.isp 
    curl "ipinfo.io/city?token=7a814b6263b02c" > /root/.city
    MYIP=$(curl -sS ipv4.icanhazip.com)
    echo -e "\e[32mloading...\e[0m" 
    clear
    izinsc="https://github.com/hokagelegend9999/ijin/raw/refs/heads/main/alpha"
    # USERNAME
    rm -f /usr/bin/user
    username=$(curl $izinsc | grep $MYIP | awk '{print $2}')
    echo "$username" >/usr/bin/user
    expx=$(curl $izinsc | grep $MYIP | awk '{print $3}')
    echo "$expx" >/usr/bin/e
    # DETAIL ORDER
    username=$(cat /usr/bin/user)
    oid=$(cat /usr/bin/ver)
    exp=$(cat /usr/bin/e)
    clear
    # CERTIFICATE STATUS
    d1=$(date -d "$valid" +%s)
    d2=$(date -d "$today" +%s)
    certifacate=$(((d1 - d2) / 86400))
    # VPS Information
    DATE=$(date +'%Y-%m-%d')
    datediff() {
        d1=$(date -d "$1" +%s)
        d2=$(date -d "$2" +%s)
        echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
    }
    mai="datediff "$Exp" "$DATE""

    # Status Expired Active
    Info="(${green}Active${NC})"
    Error="(${RED}ExpiRED${NC})"
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl $izinsc | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    sts="${Info}"
    else
    sts="${Error}"
    fi
    TIMES="10"
    CHATID="1469244768"
    KEY="8401742770:AAFs81f2dBEfAIgr9uq2i_96ryclSG95ue8"
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    ISP=$(cat /root/.isp)
    IP=$(curl -sS ipv4.icanhazip.com)
    CITY=$(cat /root/.city)
    TIMEZONE=$(printf '%(%H:%M:%S)T')
    Exp_Sc=$(curl -s $izinsc | grep $MYIP | awk '{print $3}')
    User_Sc=$(curl -s $izinsc | grep $MYIP | awk '{print $2}')

    TEXT="<b>⚡ NOTIF INSTALL SCRIPT ⚡</b>%0A"
    TEXT+="<code>─────────────────────────────</code>%0A"
    TEXT+="👤 <b>USER NAME :</b> <code>$User_Sc</code>%0A"
    TEXT+="🏢 <b>ISP        :</b> <code>$ISP</code>%0A"
    TEXT+="📍 <b>CITY       :</b> <code>$CITY</code>%0A"
    TEXT+="🌐 <b>IP VPS      :</b> <code>$IP</code>%0A"
    TEXT+="📅 <b>DATE         :</b> <code>$DATE</code>%0A"
    TEXT+="⏰ <b>TIME         :</b> <code>$TIMEZONE</code>%0A"
    TEXT+="⌛ <b>EXPIRED    :</b> <code>$Exp_Sc</code>%0A"
    TEXT+="<code>─────────────────────────────</code>%0A"
    TEXT+="👑 <b>HOKAGE LEGEND SCRIPT PREMIUM</b>%0A"
    TEXT+="<i>Automatic Notification System</i>"

    # Tombol Gabungan
    local BUTTONS='{"inline_keyboard": [[{"text": "🛒 ORDER", "url": "https://t.me/ScriptVps_Alpha_bot"}], [{"text": "🔙 KEMBALI KE MENU", "callback_data": "menu"}]]}'

    curl -s -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html&reply_markup=$BUTTONS" $URL >/dev/null
}

function ssh(){
    clear
    print_install "Memasang Password SSH"
    wget -O /etc/pam.d/common-password "${REPO}files/password"
    chmod +x /etc/pam.d/common-password

    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "

    cd
    cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

    cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

    chmod +x /etc/rc.local
    systemctl enable rc-local
    systemctl start rc-local.service

    echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
    sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
    print_success "Password SSH"
}

function udp_mini(){
    clear
    print_install "Memasang Service Limit IP & Quota"
    wget -q https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/config/fv-tunnel && chmod +x fv-tunnel && ./fv-tunnel

    mkdir -p /usr/local/kyt/
    wget -q -O /usr/local/kyt/udp-mini "${REPO}files/udp-mini"
    chmod +x /usr/local/kyt/udp-mini
    wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO}files/udp-mini-1.service"
    wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO}files/udp-mini-2.service"
    wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO}files/udp-mini-3.service"
    systemctl disable udp-mini-1
    systemctl stop udp-mini-1
    systemctl enable udp-mini-1
    systemctl start udp-mini-1
    systemctl disable udp-mini-2
    systemctl stop udp-mini-2
    systemctl enable udp-mini-2
    systemctl start udp-mini-2
    systemctl disable udp-mini-3
    systemctl stop udp-mini-3
    systemctl enable udp-mini-3
    systemctl start udp-mini-3
    print_success "Limit IP Service"
}

function ssh_slow(){
    clear
    print_install "Memasang modul SlowDNS Server"
    wget -q -O /tmp/nameserver "${REPO}files/nameserver" >/dev/null 2>&1
    chmod +x /tmp/nameserver
    
    if [[ -n "$AUTO_NS" ]]; then
        echo "Bypass input NS untuk bot Telegram..."
        sed -i '/read -p/d' /tmp/nameserver
        sed -i "2i NS_DOMAIN=\"$AUTO_NS\"" /tmp/nameserver
        sed -i "2i ns_domain=\"$AUTO_NS\"" /tmp/nameserver
        sed -i "2i nameserver=\"$AUTO_NS\"" /tmp/nameserver
        sed -i "2i domain=\"$AUTO_NS\"" /tmp/nameserver
    fi

    yes "" | bash /tmp/nameserver | tee -a /root/install.log
    print_success "SlowDNS"
}

function ins_SSHD(){
    clear
    print_install "Memasang SSHD"
    wget -q -O /etc/ssh/sshd_config "${REPO}files/sshd" >/dev/null 2>&1
    chmod 700 /etc/ssh/sshd_config
    /etc/init.d/ssh restart
    systemctl restart ssh
    /etc/init.d/ssh status
    print_success "SSHD"
}

function ins_dropbear(){
    clear
    print_install "Menginstall Dropbear"
    apt-get install dropbear -y > /dev/null 2>&1
    wget -q -O /etc/default/dropbear https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/config/dropbear.conf
    chmod +x /etc/default/dropbear
    /etc/init.d/dropbear restart
    /etc/init.d/dropbear status
    print_success "Dropbear"
}

function ins_udpSSH(){
    clear
    print_install "Menginstall Udp-custom"
    wget -q https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/udp-custom/udp-custom.sh
    chmod +x udp-custom.sh 
    bash udp-custom.sh
    rm -fr udp-custom.sh
    print_success "Udp-custom"
}

function ins_vnstat(){
    clear
    print_install "Menginstall Vnstat"
    apt -y install vnstat > /dev/null 2>&1
    /etc/init.d/vnstat restart
    apt -y install libsqlite3-dev > /dev/null 2>&1
    wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
    tar zxvf vnstat-2.6.tar.gz
    cd vnstat-2.6
    ./configure --prefix=/usr --sysconfdir=/etc && make && make install
    cd
    vnstat -u -i $NET
    sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
    chown vnstat:vnstat /var/lib/vnstat -R
    systemctl enable vnstat
    /etc/init.d/vnstat restart
    /etc/init.d/vnstat status
    rm -f /root/vnstat-2.6.tar.gz
    rm -rf /root/vnstat-2.6
    print_success "Vnstat"
}

function ins_openvpn(){
    clear
    print_install "Menginstall OpenVPN"
    wget -O openvpn https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/config/openvpn
    chmod +x openvpn && ./openvpn
    /etc/init.d/openvpn restart
    print_success "OpenVPN"
}

function ins_backup(){
    clear
    print_install "Memasang Backup Server"
    apt install rclone -y
    printf "q\n" | rclone config
    wget -O /root/.config/rclone/rclone.conf "${REPO}config/rclone.conf"
    cd /bin
    git clone  https://github.com/magnific0/wondershaper.git
    cd wondershaper
    sudo make install
    cd
    rm -rf wondershaper
    echo > /home/limit
    apt install msmtp-mta ca-certificates bsd-mailx -y
    cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user oceantestdigital@gmail.com
from oceantestdigital@gmail.com
password jokerman77 
logfile ~/.msmtp.log
EOF
    chown -R www-data:www-data /etc/msmtprc
    wget -q -O /etc/ipserver "${REPO}files/ipserver" && bash /etc/ipserver
    print_success "Backup Server"
}

function ins_swab(){
    clear
    print_install "Memasang Swap 1 G"
    gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
    curl -sL "$gotop_link" -o /tmp/gotop.deb
    dpkg -i /tmp/gotop.deb >/dev/null 2>&1
    
    dd if=/dev/zero of=/swapfile bs=1024 count=1048576
    mkswap /swapfile
    chown root:root /swapfile
    chmod 0600 /swapfile >/dev/null 2>&1
    swapon /swapfile >/dev/null 2>&1
    sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab

    chronyd -q 'server 0.id.pool.ntp.org iburst'
    chronyc sourcestats -v
    chronyc tracking -v
    
    wget ${REPO}files/bbr.sh &&  chmod +x bbr.sh && ./bbr.sh
    print_success "Swap 1 G"
}

function ins_banner(){
    clear
    print_install "Menginstall banner"
    if [ -d '/usr/local/ddos' ]; then
        echo; echo; echo "Please un-install the previous version first"
        exit 0
    else
        mkdir /usr/local/ddos
    fi

    clear
    echo "Banner /etc/kyt.txt" >>/etc/ssh/sshd_config
    sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/kyt.txt"@g' /etc/default/dropbear

    wget -O /etc/kyt.txt https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/files/issue.net
    print_success "Banner Terpasang"
}

function ins_epro(){
    clear
    print_install "Menginstall ePro WebSocket Proxy"
    wget -O /usr/bin/ws "${REPO}files/ws" >/dev/null 2>&1
    wget -O /usr/bin/tun.conf "${REPO}config/tun.conf" >/dev/null 2>&1
    wget -O /etc/systemd/system/ws.service "${REPO}files/ws.service" >/dev/null 2>&1
    chmod +x /etc/systemd/system/ws.service
    chmod +x /usr/bin/ws
    chmod 644 /usr/bin/tun.conf
    systemctl disable ws
    systemctl stop ws
    systemctl enable ws
    systemctl start ws
    systemctl restart ws
    wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
    wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
    wget -O /usr/sbin/ftvpn "${REPO}files/ftvpn" >/dev/null 2>&1
    chmod +x /usr/sbin/ftvpn
    iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
    iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
    iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
    iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
    iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
    iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
    iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
    iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
    iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
    iptables-save > /etc/iptables.up.rules
    iptables-restore -t < /etc/iptables.up.rules
    netfilter-persistent save
    netfilter-persistent reload

    cd
    apt autoclean -y >/dev/null 2>&1
    apt autoremove -y >/dev/null 2>&1
    print_success "ePro WebSocket Proxy"
}

function install_zivpn() {
    clear
    print_install "Menginstall Zivpn UDP Module (Auto-Sync Edition)"
    apt-get install jq iptables iptables-persistent netfilter-persistent -y >/dev/null 2>&1
    systemctl stop zivpn.service >/dev/null 2>&1
    mkdir -p /etc/zivpn
    
    echo -e "Downloading Zivpn Core..."
    wget -q https://github.com/zahidbd2/udp-zivpn/releases/download/udp-zivpn_1.4.9/udp-zivpn-linux-amd64 -O /usr/local/bin/zivpn
    chmod +x /usr/local/bin/zivpn
    
    cat > /etc/zivpn/config.json <<EOF
{
  "listen": ":5667",
  "cert": "/etc/zivpn/zivpn.crt",
  "key": "/etc/zivpn/zivpn.key",
  "obfs": "zivpn",
  "auth": {
    "mode": "passwords",
    "config": ["zi"]
  }
}
EOF
    chmod 644 /etc/zivpn/config.json

    echo "Generating cert files..."
    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=California/L=Los Angeles/O=Example Corp/OU=IT Department/CN=zivpn" -keyout "/etc/zivpn/zivpn.key" -out "/etc/zivpn/zivpn.crt" >/dev/null 2>&1
    
    sysctl -w net.core.rmem_max=16777216 >/dev/null 2>&1
    sysctl -w net.core.wmem_max=16777216 >/dev/null 2>&1

    echo -e "Setup Auto-Sync User..."
    cat > /usr/local/bin/zivpn-sync << 'EOF'
#!/bin/bash
CONFIG_FILE="/etc/zivpn/config.json"
if [ ! -f "$CONFIG_FILE" ]; then exit 0; fi

while IFS=: read -r username _ uid _ _ _ _; do
    if [[ "$uid" -ge 1000 && "$username" != "nobody" && "$username" != "zi" ]]; then
        if ! jq -e --arg u "$username" '.auth.config | index($u)' "$CONFIG_FILE" >/dev/null 2>&1; then
             jq --arg u "$username" '.auth.config += [$u]' "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
             mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
        fi
    fi
done < /etc/passwd
EOF
    chmod +x /usr/local/bin/zivpn-sync

    cat <<EOF > /etc/systemd/system/zivpn.service
[Unit]
Description=zivpn VPN Server
Wants=network-online.target
After=network.target network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=/etc/zivpn
ExecStartPre=/usr/local/bin/zivpn-sync
ExecStart=/usr/local/bin/zivpn server -c /etc/zivpn/config.json
Restart=always
RestartSec=3
Environment=ZIVPN_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
EOF

    echo -e "Setup Iptables Routing..."
    iptables -t nat -D PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 6000:19999 -j DNAT --to-destination :5667 2>/dev/null
    iptables -t nat -A PREROUTING -p udp --dport 6000:19999 -j REDIRECT --to-ports 5667
    iptables -I INPUT -p udp --dport 5667 -j ACCEPT
    iptables -I INPUT -p udp -m multiport --dports 6000:19999 -j ACCEPT
    netfilter-persistent save >/dev/null 2>&1
    iptables-save > /etc/iptables.up.rules

    systemctl daemon-reload
    systemctl enable zivpn.service >/dev/null 2>&1
    systemctl restart zivpn.service
    rm -f zi.* >/dev/null 2>&1
    print_success "Zivpn UDP (Auto-Sync & Anti-Reboot)"
}

function ins_restart(){
    clear
    print_install "Restarting  All Packet"
    /etc/init.d/nginx restart
    /etc/init.d/openvpn restart
    /etc/init.d/ssh restart
    /etc/init.d/dropbear restart
    /etc/init.d/vnstat restart
    systemctl restart haproxy
    /etc/init.d/cron restart
    systemctl daemon-reload
    systemctl start netfilter-persistent
    systemctl enable --now nginx
    systemctl enable --now xray
    systemctl enable --now rc-local
    systemctl enable --now dropbear
    systemctl enable --now openvpn
    systemctl enable --now cron
    systemctl enable --now haproxy
    systemctl enable --now netfilter-persistent
    systemctl enable --now ws
    history -c
    echo "unset HISTFILE" >> /etc/profile
    cd
    rm -f /root/openvpn
    rm -f /root/key.pem
    rm -f /root/cert.pem
    print_success "All Packet"
}

function menu(){
    clear
    print_install "Memasang Menu Packet"
    wget ${REPO}menu/menu.zip
    unzip menu.zip
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf menu.zip
}

function profile(){
    clear
    cat >/root/.profile <<EOF
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
mesg n || true
menu
EOF
    mkdir -p /root/.info
    curl -sS "ipinfo.io/org?token=7a814b6263b02c" > /root/.info/.isp
    cat >/etc/cron.d/xp_all <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		2 0 * * * root /usr/local/sbin/xp
                2 0 * * * root /usr/local/sbin/menu
	END
	cat >/etc/cron.d/logclean <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/20 * * * * root /usr/local/sbin/clearlog
		END
    chmod 644 /root/.profile
	
    cat >/etc/cron.d/daily_reboot <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		0 5 * * * root /sbin/reboot
	END
    cat >/etc/cron.d/limit_ip <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/2 * * * * root /usr/local/sbin/limit-ip
        END
    cat >/etc/cron.d/lim-ip-ssh <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/1 * * * * root /usr/local/sbin/limit-ip-ssh
	END
    cat >/etc/cron.d/limit_ip2 <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/2 * * * * root /usr/bin/limit-ip
	END
    echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
    echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
    service cron restart
    cat >/home/daily_reboot <<-END
		5
	END
    curl -sS "ipinfo.io/city?token=7a814b6263b02c" > /root/.info/.city
    cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF

    echo "/bin/false" >>/etc/shells
    echo "/usr/sbin/nologin" >>/etc/shells
    cat >/etc/rc.local <<EOF
#!/bin/sh -e
# rc.local
# By default this script does nothing.
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF

    chmod +x /etc/rc.local
    AUTOREB=$(cat /home/daily_reboot)
    SETT=11
    if [ $AUTOREB -gt $SETT ]; then
        TIME_DATE="PM"
    else
        TIME_DATE="AM"
    fi
    print_success "Menu Packet"
}

function enable_services(){
    clear
    print_install "Enable Service"
    systemctl daemon-reload
    systemctl start netfilter-persistent
    systemctl enable --now rc-local
    systemctl enable --now cron
    systemctl enable --now netfilter-persistent
    systemctl restart nginx
    systemctl restart xray
    systemctl restart cron
    systemctl restart haproxy
    print_success "Enable Service"
    clear
}
