#!/bin/bash
# ===========================================
#  Anti-Judol Termux Edition 🗿✌🏼
#  Author : d4nu-ghost
#  Deskripsi:
#   - Update blocklist
#   - Jalanin dnsmasq di Termux
#   - Cek domain judol
# ===========================================

BLOCKLIST_URL="https://raw.githubusercontent.com/anti-judol/blocklist/main/judol-blocklist.txt"
TARGET="$HOME/.judol-blocklist.conf"

# List domain default buat pengecekan
DOMAINS=(
    "judi-slot.com"
    "slot-gacor.net"
    "judi-online123.xyz"
    "bola88.org"
    "casino-online.vip"
)

echo "=== 🗿 Anti-Judol Termux Edition by d4nu-ghost ==="
echo "⬇️ Download blocklist terbaru dari $BLOCKLIST_URL"

curl -sSL "$BLOCKLIST_URL" -o "$TARGET"

if [ $? -eq 0 ]; then
    echo "✅ Blocklist berhasil diupdate: $TARGET"
else
    echo "❌ Gagal download blocklist. Cek URL/koneksi internet."
    exit 1
fi

echo "🔄 Menjalankan dnsmasq di Termux..."
# Stop dulu kalau ada dnsmasq lama
pkill dnsmasq 2>/dev/null

# Jalankan dnsmasq dengan blocklist
dnsmasq --conf-file="$TARGET" --no-daemon --log-queries &
sleep 2

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
