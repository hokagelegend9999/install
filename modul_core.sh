#!/bin/bash

# Buat direktori xray
function make_folder_xray() {
    print_install "Membuat direktori xray"
    mkdir -p /etc/xray
    curl -s ifconfig.me > /etc/xray/ipvps
    touch /etc/xray/domain
    mkdir -p /var/log/xray
    chown www-data.www-data /var/log/xray
    chmod +x /var/log/xray
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
    mkdir -p /var/lib/kyt >/dev/null 2>&1
    # // Ram Information
    while IFS=":" read -r a b; do
    case $a in
        "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
        "Shmem") ((mem_used+=${b/kB}))  ;;
        "MemFree" | "Buffers" | "Cached" | "SReclaimable")
        mem_used="$((mem_used-=${b/kB}))"
    ;;
    esac
    done < /proc/meminfo
    Ram_Usage="$((mem_used / 1024))"
    Ram_Total="$((mem_total / 1024))"
    export tanggal=`date -d "0 days" +"%d-%m-%Y - %X" `
    export OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
    export Kernel=$( uname -r )
    export Arch=$( uname -m )
    export IP=$( curl -s https://ipinfo.io/ip/ )

    rm -rf /etc/vmess/.vmess.db
    rm -rf /etc/vless/.vless.db
    rm -rf /etc/trojan/.trojan.db
    rm -rf /etc/shadowsocks/.shadowsocks.db
    rm -rf /etc/ssh/.ssh.db
    rm -rf /etc/bot/.bot.db
    rm -rf /etc/user-create/user.log
    mkdir -p /etc/bot
    mkdir -p /etc/vmess
    mkdir -p /etc/vless
    mkdir -p /etc/trojan
    mkdir -p /etc/shadowsocks
    mkdir -p /etc/ssh
    mkdir -p /usr/bin/xray/
    mkdir -p /var/www/html
    mkdir -p /etc/kyt/limit/vmess/ip
    mkdir -p /etc/kyt/limit/vless/ip
    mkdir -p /etc/kyt/limit/trojan/ip
    mkdir -p /etc/kyt/limit/ssh/ip
    mkdir -p /etc/limit/vmess
    mkdir -p /etc/limit/vless
    mkdir -p /etc/limit/trojan
    mkdir -p /etc/limit/ssh
    mkdir -p /etc/user-create
    touch /etc/vmess/.vmess.db
    touch /etc/vless/.vless.db
    touch /etc/trojan/.trojan.db
    touch /etc/shadowsocks/.shadowsocks.db
    touch /etc/ssh/.ssh.db
    touch /etc/bot/.bot.db
    echo "& plughin Account" >>/etc/vmess/.vmess.db
    echo "& plughin Account" >>/etc/vless/.vless.db
    echo "& plughin Account" >>/etc/trojan/.trojan.db
    echo "& plughin Account" >>/etc/shadowsocks/.shadowsocks.db
    echo "& plughin Account" >>/etc/ssh/.ssh.db
    echo "echo -e 'Vps Config User Account'" >> /etc/user-create/user.log
}

# Fungsi input domain
function pasang_domain() {
    echo -e ""
    clear
    echo -e "   .----------------------------------."
    echo -e "   |\e[1;32mPILIH DOMAIN SILAHKAN \e[0m|"
    echo -e "   '----------------------------------'"
    echo -e "     \e[1;32m1)\e[0m Menggunakan Domain Sendiri"
    echo -e "     \e[1;32m2)\e[0m Menggunakan Domain Script"
    echo -e "   ------------------------------------"
    read -p "   Please select numbers 1-2 or Any Button(Random) : " host
    echo ""
    if [[ $host == "1" ]]; then
    echo -e "   \e[1;32mPlease Enter Your Subdomain $NC"
    read -p "   Subdomain: " host1
    echo "IP=" >> /var/lib/kyt/ipvps.conf
    echo $host1 > /etc/xray/domain
    echo $host1 > /root/domain
    echo ""
    elif [[ $host == "2" ]]; then
    #install cf
    wget ${REPO}files/cf.sh && chmod +x cf.sh && ./cf.sh
    rm -f /root/cf.sh
    clear
    else
    print_install "Random Subdomain/Domain is Used"
    clear
    fi
}

# Pasang SSL
function pasang_ssl() {
    clear
    print_install "Memasang SSL Pada Domain"
    rm -rf /etc/xray/xray.key
    rm -rf /etc/xray/xray.crt
    domain=$(cat /root/domain)
    STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl stop $STOPWEBSERVER
    systemctl stop nginx
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    chmod 777 /etc/xray/xray.key
    print_success "SSL Certificate"
}

#Instal Xray
function install_xray() {
    clear
    print_install "Core Xray Latest Version"
    domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
    chown www-data.www-data $domainSock_dir
    
    # / / Ambil Xray Core Version Terbaru
    latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version

    # // Ambil Config Server
    wget -O /etc/xray/config.json "${REPO}config/config.json" >/dev/null 2>&1
    wget -O /etc/systemd/system/runn.service "${REPO}files/runn.service" >/dev/null 2>&1
    domain=$(cat /etc/xray/domain)
    IPVS=$(cat /etc/xray/ipvps)
    print_success "Core Xray 1.8.1 Latest Version"
    
    # Settings UP Nginix Server
    clear
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    print_install "Memasang Konfigurasi Packet"
    wget -O /etc/haproxy/haproxy.cfg "${REPO}config/haproxy.cfg" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "${REPO}config/xray.conf" >/dev/null 2>&1
    sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
    sudo curl -fsSL https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/config/nginx.conf -o /etc/nginx/nginx.conf
    
    cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem

    # > Set Permission
    chmod +x /etc/systemd/system/runn.service

    # > Create Service
    rm -rf /etc/systemd/system/xray.service.d
    cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF
    print_success "Konfigurasi Packet"
}

function downgrade_xray() {
    local TARGET_VERSION="v25.1.30"
    local TARGET_URL="https://github.com/XTLS/Xray-core/releases/download/${TARGET_VERSION}/Xray-linux-64.zip"
    local XRAY_PATH="/usr/local/bin/xray"
    
    echo -e "${BLUE}=====================================================${NC}"
    echo -e "${BLUE}     DOWNGRADING XRAY TO ${TARGET_VERSION}           ${NC}"
    echo -e "${BLUE}=====================================================${NC}"
    
    # Stop Service
    systemctl stop xray
    
    # Backup Binary Terbaru
    if [ -f "$XRAY_PATH" ]; then
        mv $XRAY_PATH /usr/local/bin/xray.latest
    fi
    
    # Download Target Version
    mkdir -p /tmp/xray_downgrade
    cd /tmp/xray_downgrade
    wget -q $TARGET_URL
    
    if [ $? -eq 0 ]; then
        unzip -o Xray-linux-64.zip > /dev/null 2>&1
        mv xray $XRAY_PATH
        chmod +x $XRAY_PATH
        echo -e "${GREEN}Xray berhasil di-downgrade ke ${TARGET_VERSION}${NC}"
    else
        echo -e "${RED}Gagal download versi downgrade! Mengembalikan versi terbaru...${NC}"
        mv /usr/local/bin/xray.latest $XRAY_PATH
    fi
    
    rm -rf /tmp/xray_downgrade
    systemctl restart xray
    cd /root
}
