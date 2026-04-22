#!/bin/bash

### Cek root
function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user Start installation process"
    else
        print_error "The current user is not the root user, please switch to the root user and run the script again"
    fi
}

function check_system_arch() {
    # // Checking Os Architecture
    if [[ $( uname -m | awk '{print $1}' ) == "x86_64" ]]; then
        echo -e "${OK} Your Architecture Is Supported ( ${green}$( uname -m )${NC} )"
    else
        echo -e "${EROR} Your Architecture Is Not Supported ( ${YELLOW}$( uname -m )${NC} )"
        exit 1
    fi

    # // Checking System
    if [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "ubuntu" ]]; then
        echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
    elif [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "debian" ]]; then
        echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
    else
        echo -e "${EROR} Your OS Is Not Supported ( ${YELLOW}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
        exit 1
    fi

    # // IP Address Validating
    if [[ $IP == "" ]]; then
        echo -e "${EROR} IP Address ( ${YELLOW}Not Detected${NC} )"
    else
        echo -e "${OK} IP Address ( ${green}$IP${NC} )"
    fi
}

# Change Environment System
function first_setup(){
    timedatectl set-timezone Asia/Jakarta

    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections

    print_install "Setup Dependencies & Install HAProxy"

    apt update -y
    apt install -y --no-install-recommends software-properties-common curl gnupg2 lsb-release ca-certificates

    # Install HAProxy dari repo default OS (paling aman)
    apt update -y
    DEBIAN_FRONTEND=noninteractive apt install -y -o Dpkg::Options::="--force-confold" haproxy

    # Pastikan haproxy benar-benar terinstall
    if ! command -v haproxy >/dev/null 2>&1; then
        echo -e "${RED}HAProxy gagal terinstall!${NC}"
        exit 1
    fi

    systemctl daemon-reload
    systemctl enable haproxy >/dev/null 2>&1
    systemctl restart haproxy >/dev/null 2>&1

    print_success "HAProxy Installed"
}

# GEO PROJECT
function nginx_install() {
    clear
    # // Checking System
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
        print_install "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        # // sudo add-apt-repository ppa:nginx/stable -y 
        sudo apt-get install nginx -y 
    elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
        print_success "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        apt -y install nginx 
    else
        echo -e " Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
        # // exit 1
    fi
}

# Update and remove packages
function base_package() {
    clear
    ########
    print_install "Menginstall Packet Yang Dibutuhkan"
    apt install zip pwgen openssl netcat socat cron bash-completion -y
    apt install figlet -y
    apt update -y
    apt upgrade -y
    apt dist-upgrade -y
    systemctl enable chronyd
    systemctl restart chronyd
    systemctl enable chrony
    systemctl restart chrony
    chronyc sourcestats -v
    chronyc tracking -v
    apt install ntpdate -y
    ntpdate pool.ntp.org
    apt install sudo -y
    apt install ruby -y 
    gem install lolcat
    sudo apt-get clean all
    sudo apt-get autoremove -y
    sudo apt-get install -y debconf-utils
    sudo apt-get remove --purge exim4 -y
    sudo apt-get remove --purge ufw firewalld -y
    sudo apt-get install -y --no-install-recommends software-properties-common
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
    print_success "Packet Yang Dibutuhkan"
}
