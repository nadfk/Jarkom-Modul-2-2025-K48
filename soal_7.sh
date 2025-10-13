#tirion

nano /etc/bind/db.k48.com

# tambahkan

; A Records for Servers
sirion      IN      A       192.235.3.2
lindon      IN      A       192.235.3.10
vingilot    IN      A       192.235.3.11

; CNAME Aliases
www         IN      CNAME   sirion.<xxxx>.com.
static      IN      CNAME   lindon.<xxxx>.com.
app         IN      CNAME   vingilot.<xxxx>.com.

ubah serial dari 2025101301 menjadi 2025101302 

systemctl restart bind9

# cek pada dua klien berbeda (ex earendil)
host www.k48.com
host static.k48.com
host app.k48.com

#hasil harus konsisten