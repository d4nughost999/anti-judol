#!/bin/bash
# ===========================================
#  Anti-Judol All-in-One 🗿✌🏼
#  Author : d4nu-ghost
#  Deskripsi:
#   1. Auto-update blocklist dari repo
#   2. Restart service dnsmasq / Pi-hole
#   3. Cek apakah domain judol udah diblokir
# ===========================================

BLOCKLIST_URL="https://raw.githubusercontent.com/anti-judol/blocklist/main/judol-blocklist.txt"

DNSMASQ_DIR="/etc/dnsmasq.d"
PIHOLE_DIR="/etc/pihole"

# List domain default buat pengecekan
DOMAINS=(
    "judi-slot.com"
    "slot-gacor.net"
    "judi-online123.xyz"
    "bola88.org"
    "casino-online.vip"
)

# Tentuin file tujuan
if [ -d "$DNSMASQ_DIR" ]; then
    TARGET="$DNSMASQ_DIR/judol-blocklist.conf"
    SERVICE="dnsmasq"
elif [ -d "$PIHOLE_DIR" ]; then
    TARGET="$PIHOLE_DIR/judol-blocklist.txt"
    SERVICE="pihole"
else
    echo "❌ dnsmasq / Pi-hole tidak ditemukan di sistem ini."
    exit 1
fi

echo "=== 🗿 Anti-Judol All-in-One by d4nu-ghost ==="
echo "⬇️ Download blocklist terbaru dari $BLOCKLIST_URL"

sudo curl -sSL "$BLOCKLIST_URL" -o "$TARGET"

if [ $? -eq 0 ]; then
    echo "✅ Blocklist berhasil diupdate: $TARGET"

    if [ "$SERVICE" == "dnsmasq" ]; then
        sudo systemctl restart dnsmasq
        echo "🔄 dnsmasq direstart!"
    elif [ "$SERVICE" == "pihole" ]; then
        sudo pihole -g
        echo "🔄 Pi-hole gravity updated!"
    fi
else
    echo "❌ Gagal download blocklist. Cek URL atau koneksi internet."
    exit 1
fi

echo ""
echo "=== 🔎 Cek Status Blokir Judol ==="
for domain in "${DOMAINS[@]}"; do
    IP=$(getent hosts "$domain" | awk '{ print $1 }')
    if [ "$IP" == "127.0.0.1" ]; then
        echo "✅ $domain diblokir (IP: $IP)"
    elif [ -n "$IP" ]; then
        echo "⚠️  $domain masih aktif (IP: $IP)"
    else
        echo "❌ $domain tidak bisa di-resolve (mungkin down)"
    fi
done
