# Akses melalui Vingilot

apt-get update -y
apt-get install -y nginx php8.4-fpm

# Membuat direktori root untuk web
mkdir -p /var/www/app

# Membuat file index.php (beranda)
cat > /var/www/app/index.php <<'PHP'
<?php
echo "<h1>Vingilot Mengarungi Samudera Digital!</h1>";
echo "<p>Ini adalah halaman utama yang dinamis.</p>";
?>
PHP

# Membuat file about.php (halaman tentang)
cat > /var/www/app/about.php <<'PHP'
<?php
echo "<h2>Kisah Sang Navigator, Vingilot</h2>";
echo "<p>Halaman ini diakses melalui rewrite URL.</p>";
?>
PHP

cat > /etc/nginx/sites-available/app.conf <<'NGINX'
server {
    listen 80;
    server_name app.k48.com;

    root /var/www/app;
    index index.php;

    # Blok untuk URL rewrite /about
    location = /about {
        return 301 /about/; # Menambahkan trailing slash
    }
    location = /about/ {
        rewrite ^ /about.php last; # Menyajikan about.php tanpa mengubah URL
    }

    # Aturan umum untuk file dan direktori
    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    # Meneruskan semua file .php ke PHP-FPM untuk diproses
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock; # Jembatan ke PHP
    }
}
NGINX

# Mengaktifkan situs baru
ln -sf /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/app.conf

# Menghapus konfigurasi default
rm -f /etc/nginx/sites-enabled/default

# Memeriksa sintaks konfigurasi
nginx -t

# Memulai ulang layanan PHP-FPM dan Nginx
service php8.4-fpm start || service php-fpm start
service nginx restart

# Verifikasi di client(ex Earendil)
lynx http://app.k48.com
lynx http://app.k48.com/about