#triton

dig @192.235.3.20 k48.com SOA

#valmar
ls -l /var/lib/bind #cek ada file db.K48.com

dig @192.235.3.21 k48.com SOA

#cocokan answer section for SOA

# untuk lacak log Valmar 
apt update && apt install journalctl -y 
journalctl -xeu bind9 | grep transfer 
#Verifikasi akhir di Valmar 
dig @127.0.0.1 K48.com 
dig @127.0.0.1 eonwe.K48.com