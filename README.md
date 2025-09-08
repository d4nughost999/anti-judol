# 🗿 Anti-Judol All-in-One
Author: d4nu-ghost  

Script Linux sederhana untuk memblokir situs judi online (judol) menggunakan dnsmasq atau Pi-hole.  

## ✨ Fitur
- 🔄 Auto-update blocklist dari GitHub  
- ⚡ Restart service dnsmasq / Pi-hole otomatis  
- 🔎 Cek apakah domain judol sudah diblokir  

---

## 📦 Instalasi versi Linux

# Clone repo
git clone https://github.com/d4nughost999/anti-judol.git

# Masuk ke folder repo
cd anti-judol

# Kasih izin eksekusi ke script Linux
chmod +x d4nu-ghost-anti-judol.sh

# Jalankan script
sudo ./d4nu-ghost-anti-judol.sh



## 📦 Instalasi versi Termux

# Update & install paket dasar
pkg update && pkg upgrade -y
pkg install git curl -y

# Clone repo
git clone https://github.com/d4nughost999/anti-judol.git

# Masuk ke folder repo
cd anti-judol

# Kasih izin eksekusi ke script Termux
chmod +x d4nu-ghost-anti-judol-termux.sh

# Jalankan script
./d4nu-ghost-anti-judol-termux.sh
