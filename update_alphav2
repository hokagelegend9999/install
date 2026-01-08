#!/bin/bash

# Pastikan lolcat terinstall untuk pewarnaan header
if ! command -v lolcat &> /dev/null; then
    apt-get install ruby -y &> /dev/null
    gem install lolcat &> /dev/null
fi

clear

# --- FUNGSI ANIMASI LOADING ---
fun_bar() {
    CMD="$1"
    
    # Menjalankan perintah di background
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        $CMD >/dev/null 2>&1 # Menjalankan fungsi res1 tanpa output ke layar
        touch $HOME/fim      # Membuat file penanda selesai
    ) >/dev/null 2>&1 &

    # Memulai Animasi
    tput civis # Sembunyikan kursor
    echo -ne "  \033[0;33mSedang Memproses Update \033[1;37m- \033[0;33m["
    
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        
        # Cek jika file penanda sudah ada (artinya res1 selesai)
        if [[ -e $HOME/fim ]]; then
            rm $HOME/fim
            break
        fi
        
        # Reset baris jika belum selesai
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33mSedang Memproses Update \033[1;37m- \033[0;33m["
    done
    
    # Tampilan Selesai
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m SUKSES !\033[1;37m"
    tput cnorm # Tampilkan kursor kembali
}

# --- FUNGSI UPDATE UTAMA ---
res1() {
    # 1. Download & Install FV Tunnel
    wget -qO- fv-tunnel "https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/config/fv-tunnel" 
    chmod +x fv-tunnel 
    bash fv-tunnel
    rm -rf fv-tunnel
    
    # 2. Bersihkan Folder sbin
    rm -rf /usr/local/sbin/*
    
    # 3. Download & Pasang Menu Baru
    wget https://github.com/hokagelegend9999/alpha.v2/raw/refs/heads/main/menu/menu.zip
    unzip -o menu.zip > /dev/null 2>&1
    chmod +x menu/*
    mv menu/* /usr/local/sbin/
    rm -rf menu
    rm -rf menu.zip
    
    # 4. Download Menu Utama Spesifik
    wget -q -O menu https://raw.githubusercontent.com/hokagelegend9999/alpha.v2/refs/heads/main/menu/menu
    mv menu /usr/local/sbin/
    chmod +x /usr/local/sbin/menu
    chmod +x /etc/ssh/usage_db/
    
    # 5. FIX WINDOWS LINE ENDING (PENTING)
    # Ini membersihkan semua script di sbin dari error ^M
    sed -i 's/\r$//' /usr/local/sbin/*

    # 6. Setup Cronjob
    cat >/etc/cron.d/ssh_accountant <<-END
    SHELL=/bin/sh
    PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
    * * * * * root /usr/local/sbin/ssh-accountant
END

    # Restart service cron agar efek berjalan
    service cron restart
}

# --- EKSEKUSI ---
rm -rf update.sh
clear
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " \e[1;97;101m UPDATE SCRIPT SEDANG BERJALAN !             \e[0m"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e ""
echo -e "  \033[1;91m Update Script Service & Menu\033[1;37m"

# Panggil fungsi animasi dengan argumen fungsi res1
fun_bar 'res1'

echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e ""
echo -e " \033[1;32m Update Selesai! Silakan cek menu.\033[0m"
echo -e ""
read -n 1 -s -r -p "Tekan [ Enter ] untuk kembali ke menu"
menu
