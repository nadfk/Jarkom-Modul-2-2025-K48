#Lindon
apt update -y && apt install nginx -y

mkdir -p /var/www/static/annals

touch /var/www/static/index.html
nano /var/www/static/index.html
# tambahkan
'HTML'
<!doctype html>
<title>Lampion Lindon</title>
<h1>Selamat Datang di Pelabuhan Statis Lindon</h1>
<p>Akses <a href="/annals/">/annals/</a> untuk melihat arsip.</p>
HTML

touch /var/www/static/annals/catatan_pelayaran.txt
nano /var/www/static/annals/catatan_pelayaran.txt
# tambahkan
'TXT'
Ini adalah arsip dari Pelabuhan Lindon.
Directory listing (autoindex) aktif.
TXT

touch /etc/nginx/sites-available/static.conf
nano /etc/nginx/sites-available/static.conf
#tambahkan 
'NGINX'
server {
    listen 80;
    server_name static.k48.com;
    root /var/www/static;
    index index.html;

    location /annals/ {
        autoindex on;
    }
}
NGINX

# Membuat symbolic link untuk mengaktifkan situs
ln -sf /etc/nginx/sites-available/static.conf /etc/nginx/sites-enabled/static.conf

# Menghapus konfigurasi default jika ada
rm -f /etc/nginx/sites-enabled/default

# Memeriksa sintaks konfigurasi
nginx -t

# Memulai ulang layanan Nginx
service nginx restart


# Testing di client (ex Earendil)
apt update && apt install lynx -y
lynx http://static.k48.com
lynx http://static.k48.com/annals/