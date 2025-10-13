# Laporan Resmi Praktikum Jarkom Modul 2

| Nama Anggota | NRP |
|--------------|-----|
|Khumaidi Kharis A. | 5027241049|
|Nadia Fauziazahra K. | 5027241094|


## nomor 1-3

    =====[Eonwe]=====
    auto eth0
    iface eth0 inet dhcp
    
    auto eth1
        iface eth1 inet static
        	address 192.235.1.1
        	netmask 255.255.255.0
        
        auto eth2
        iface eth2 inet static
        	address 192.235.2.1
        	netmask 255.255.255.0
        
        auto eth3
        iface eth3 inet static
        	address 192.235.3.1
        	netmask 255.255.255.0
    
    up apt update && apt install iptables -y
    up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.235.0.0/16
    
    =====[Earendil]=====
    auto eth0
        iface eth0 inet static
        	address 192.235.1.2
        	netmask 255.255.255.0
        	gateway 192.235.1.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 192.235.3.21 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Elwing]=====
    auto eth0
        iface eth0 inet static
        	address 192.235.1.3
        	netmask 255.255.255.0
        	gateway 192.235.1.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 192.235.3.21 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Cirdan]=====
    auto eth0
    iface eth0 inet static
        address 192.235.2.2
        netmask 255.255.255.0
        gateway 192.235.2.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 192.235.3.21 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Elrond]=====
    auto eth0
    iface eth0 inet static
        address 192.235.2.3
        netmask 255.255.255.0
        gateway 192.235.2.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 192.235.3.21 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Maglor]=====
    auto eth0
    iface eth0 inet static
        address 192.235.2.4
        netmask 255.255.255.0
        gateway 192.235.2.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 192.235.3.21 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Sirion]=====
    auto eth0
    iface eth0 inet static
        address 192.235.3.2
        netmask 255.255.255.0
        gateway 192.235.3.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 192.235.3.21 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Triton]=====
    auto eth0
    iface eth0 inet static
        address 192.235.3.20
        netmask 255.255.255.0
        gateway 192.235.3.1
    
    up echo nameserver 127.0.0.1 > /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Valmar]=====
    auto eth0
    iface eth0 inet static
        address 192.235.3.21
        netmask 255.255.255.0
        gateway 192.235.3.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 127.0.0.1 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Lindon]=====
    auto eth0
    iface eth0 inet static
        address 192.235.3.10
        netmask 255.255.255.0
        gateway 192.235.3.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 192.235.3.21 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf
    
    =====[Vingilot]=====
    auto eth0
    iface eth0 inet static
        address 192.235.3.11
        netmask 255.255.255.0
        gateway 192.235.3.1
    
    up echo nameserver 192.235.3.20 > /etc/resolv.conf
    up echo nameserver 192.235.3.21 >> /etc/resolv.conf
    up echo nameserver 192.168.122.1 >> /etc/resolv.conf

## Nomor 4

    # Tirion
    apt update && apt install bind9 -y
    apt install systemctl -y
    
    nano /etc/bind/named.conf.options
    options {
        directory "/var/cache/bind";
        forwarders {
            192.168.122.1;
        };
        allow-query{any;};
        listen-on { 192.235.3.20; 127.0.0.1; };
    };
    
    nano /etc/bind/named.conf.local
    zone "K48.com" {
        type master;
        file "/etc/bind/db.K48.com";
        allow-transfer { 192.235.3.21; };
        also-notify { 192.235.3.21; };
        notify yes; 
    };
    
    nano /etc/bind/db.K48.com
    $TTL    604800
    @       IN      SOA     ns1.K48.com. root.K48.com. (
                                  2025101301 ; Serial (Harus dinaikkan jika ada perubahan!)
                                  604800     ; Refresh
                                   86400     ; Retry
                                2419200      ; Expire
                                  604800 )   ; Negative Cache TTL
    
    @       IN      NS      ns1.K48.com.
    @       IN      NS      ns2.K48.com.
    
    ; A Record untuk Nameserver
    ns1     IN      A       192.235.3.20
    ns2     IN      A       192.235.3.21
    
    ; A Record Apex (Front Door)
    @       IN      A       192.235.3.22
    
    # cek 
    named-checkzone K48.com /etc/bind/db.K48.com
    named-checkconf
    systemctl restart bind9
    systemctl status bind9
    
    
    # Valmar
    apt update && apt install bind9 -y
    apt install systemctl -y
    
    nano /etc/bind/named.conf.options
    options {
        directory "/var/cache/bind";
        forwarders {
            192.168.122.1;
        };
        allow-query{any;};
        listen-on { 192.235.3.21; 127.0.0.1; };
    };
    
    nano /etc/bind/named.conf.local
    zone "K48.com" {
        type slave;
        file "var/lib/bind/db.K48.com";
        masters { 192.235.3.20; }; 
    };
    
    named-checkconf
    systemctl restart bind9
    systemctl status bind9
    
    dig @127.0.0.1 K48.com
    
    # Di terminal Earendil, Elwing, Sirion, Tirion, dst.
    sudo apt update 
    dig ns1.K48.com
    dig ns2.K48.com
    dig google.com 

## Nomor 5

    nano /etc/bind/db.K48.com
    
    # tambahin ke config
    
    $TTL    604800
    @       IN      SOA     ns1.K48.com. root.K48.com. (
                                  2025101302 ; Serial (Harus dinaikkan jika ada perubahan!)
                                  604800     ; Refresh
                                   86400     ; Retry
                                2419200      ; Expire
                                  604800 )   ; Negative Cache TTL
    
    @       IN      NS      ns1.K48.com.
    @       IN      NS      ns2.K48.com.
    
    ; A Record untuk Nameserver
    ns1     IN      A       192.235.3.20
    ns2     IN      A       192.235.3.21
    
    ; A Record Apex (Front Door)
    @       IN      A       192.235.3.22
    eonwe       IN  A   192.235.3.1
    earendil    IN  A   192.235.1.2
    elwing      IN  A   192.235.1.3
    cirdan      IN  A   192.235.2.2
    elrond      IN  A   192.235.2.3
    maglor      IN  A   192.235.2.4
    lindon      IN  A   192.235.3.23
    vingilot    IN  A   192.235.3.24
    
    # di tirion
    named-checkzone K48.com /etc/bind/db.K48.com
    named-checkconf
    systemctl restart bind9
    systemctl status bind9
    
    #di valmar
    
    systemctl restart bind9
    systemctl status bind9
    
    #testing di tirion
    dig @127.0.0.1 K48.com
    dig @127.0.0.1 eonwe.K48.com
    
    #testing di Valmar/ns
    dig @127.0.0.1 K48.com
    
    #testing di klien
    dig K48.com
    dig eonwe.K48.com
    dig google.com

## Nomor 6

    #triton
    
    dig @192.235.3.20 k48.com SOA
    
    #valmar
    ls -l /var/lib/bind #cek ada file db.K48.com
    
    dig @192.235.3.21 k48.com SOA
    
    #cocokan answer section for SOA

untuk lacak log Valmar
    ``
    apt update && apt install journalctl -y
    journalctl -xeu bind9 | grep transfer
    ``
Verifikasi akhir di Valmar
    ``
    dig @127.0.0.1 K48.com
    dig @127.0.0.1 eonwe.K48.com
    ``
## Nomor 7

    #tirion
    
    nano /etc/bind/db.k48.com
    
    # tambahkan
    
    ; A Records for Servers
    sirion      IN      A       192.235.3.2
    lindon      IN      A       192.235.3.10
    vingilot    IN      A       192.235.3.11
    
    ; CNAME Aliases
    www         IN      CNAME   sirion.k48.com.
    static      IN      CNAME   lindon.k48.com.
    app         IN      CNAME   vingilot.k48.com.

    ubah serial dari 2025101301 menjadi 2025101302 
    
    systemctl restart bind9
    
    # cek pada dua klien berbeda (ex earendil)
    host www.k48.com
    host static.k48.com
    host app.k48.com

hasil harus konsisten 

## Nomor 8

```
# Tirion

nano /etc/bind/named.conf.local

# Tambahkan blok ini di bawah konfigurasi zone "k48.com" Anda
zone "3.235.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.235.3";   // Ini adalah file BARU yang akan kita buat
    allow-transfer { 192.235.3.21; };   // Izinkan Valmar menyalin
    also-notify { 192.235.3.21; };      // Beri tahu Valmar jika ada update
};

nano /etc/bind/db.192.235.3

# isi code berikut
$TTL    604800
@       IN      SOA     tirion.k48.com. root.k48.com. (
                      2025101303     ; Serial (PENTING: Naikkan angkanya!)
                      604800         ; Refresh
                      86400          ; Retry
                      2419200        ; Expire
                      604800 )       ; Negative Cache TTL
;
; Name Server Record
@       IN      NS      tirion.k48.com.

; --- Pointer (PTR) Records ---
; [Oktet terakhir IP]   IN PTR   [Hostname.]
2       IN      PTR     sirion.k48.com.
10      IN      PTR     lindon.k48.com.
11      IN      PTR     vingilot.k48.com.

service bind9 restart

# Valmar

nano /etc/bind/named.conf.local

# Tambahkan blok ini di Valmar
zone "3.235.192.in-addr.arpa" {
    type slave;
    masters { 192.235.3.20; }; // Tentukan IP master (Tirion)
    file "/var/lib/bind/db.192.235.3";
};

service bind9 restart

# cek di client (ex Earendil)

# Cek IP Sirion
host 192.235.3.2
# Cek IP Lindon
host 192.235.3.10
# Cek IP Vingilot
host 192.235.3.11
```
