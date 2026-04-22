#!/bin/bash

# Fungsi Update Progress Bar (Realtime)
function update_progress() {
    local percent="$1"
    local status="$2"
    local token="$BOT_TOKEN"

    # Jika tidak dijalankan oleh bot (Manual SSH), skip lapor ke Telegram
    if [[ -z "$AUTO_CHATID" ]]; then return; fi

    # Logika Bar (20 Kotak)
    local completed=$(( percent / 5 ))
    local remaining=$(( 20 - completed ))
    local bar=""
    for ((i=0; i<completed; i++)); do bar+="█"; done
    for ((i=0; i<remaining; i++)); do bar+="░"; done

    local text="🚀 <b>INSTALLATION IN PROGRESS</b>%0A"
    text+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬%0A"
    text+="📡 <b>Target IP:</b> <code>$IP</code>%0A"
    text+="🛠 <b>Status:</b> <i>$status</i>%0A%0A"
    text+="<code>[$bar] $percent%</code>%0A"
    text+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬%0A"
    text+="💻 <b>Mohon Tunggu, Jangan Close Bot...</b>"
    text+="Tinggal Ngopi..Aja..%0A"

    # Kirim Request Edit Pesan ke Telegram
    curl -s -X POST "https://api.telegram.org/bot${token}/editMessageText" \
        -d chat_id="${AUTO_CHATID}" \
        -d message_id="${AUTO_MSGID}" \
        -d text="${text}" \
        -d parse_mode="html" > /dev/null 2>&1
}

# Fungsi Laporan Akhir (Selesai)
function send_final_report() {
    if [[ -z "$AUTO_CHATID" ]]; then return; fi
    
    local domain_vps=$(cat /etc/xray/domain 2>/dev/null || echo "Belum Diset")
    local TEXT_FINAL="✅ <b>INSTALLATION COMPLETED!</b>%0A"
    TEXT_FINAL+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬%0A"
    TEXT_FINAL+="📡 <b>IP VPS   :</b> <code>$IP</code>%0A"
    TEXT_FINAL+="🌐 <b>Domain   :</b> <code>$domain_vps</code>%0A"
    TEXT_FINAL+="📅 <b>Waktu    :</b> <code>$(date)</code>%0A"
    TEXT_FINAL+="▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬%0A"
    TEXT_FINAL+="Server sedang melakukan <b>Reboot</b> otomatis.%0A"
    TEXT_FINAL+="Silakan tunggu Persiapan  script Lalu Login .%0A%0A"
    TEXT_FINAL+="🚀 <i>Hokage Legend Auto script</i>"

    local KEYBOARD='{"inline_keyboard": [[{"text": "🔙 KEMBALI KE MENU", "callback_data": "menu"}]]}'

    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/editMessageText" \
         -d chat_id="$AUTO_CHATID" \
         -d message_id="$AUTO_MSGID" \
         -d text="$TEXT_FINAL" \
         -d parse_mode="html" \
         -d reply_markup="$KEYBOARD"
}
