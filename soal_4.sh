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