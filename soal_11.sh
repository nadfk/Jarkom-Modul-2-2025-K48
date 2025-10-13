# Akses melalui Sirion

apt-get update -y
apt-get install -y nginx

echo "192.235.3.10 lindon.k48.com" >> /etc/hosts
echo "192.235.3.11 vingilot.k48.com" >> /etc/hosts

cat > /etc/nginx/sites-available/reverse-proxy.conf <<'NGINX'
server {
    listen 80;
    # Menerima permintaan untuk kedua hostname
    server_name www.k48.com sirion.k48.com;

    # Aturan untuk /static/
    location /static/ {
        # Teruskan permintaan ke Lindon
        proxy_pass http://lindon.k48.com/;

        # Meneruskan header asli dari klien
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # Aturan untuk /app/
    location /app/ {
        # Teruskan permintaan ke Vingilot
        proxy_pass http://vingilot.k48.com/;

        # Meneruskan header asli dari klien
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
NGINX

# Mengaktifkan situs reverse proxy
ln -sf /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf

# Menghapus konfigurasi default
rm -f /etc/nginx/sites-enabled/default

# Memeriksa sintaks konfigurasi
nginx -t

# Memulai ulang layanan Nginx
service nginx restart


# Verifikasi di client (ex Earendil)
lynx http://www.k48.com/static/
lynx http://www.k48.com/app/