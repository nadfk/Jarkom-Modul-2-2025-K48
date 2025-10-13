#Tirion

#edit konfigurasi
nano /etc/bind/named.conf.local

zone "3.235.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.235.3";
    allow-transfer { 192.235.3.21; };
    also-notify { 192.235.3.21; };
    notify yes;
};

nano /etc/bind/db.192.235.3

$TTL 604800
@   IN  SOA tirion.K48.com. root.K48.com. (
        2025101303 ; Serial
        604800     ; Refresh
        86400      ; Retry
        2419200    ; Expire
        604800 )   ; Negative Cache TTL
;

@   IN  NS  tirion.K48.com.

; PTR records (segmen 192.235.3.0/24)
2    IN  PTR  sirion.K48.com.
11   IN  PTR  vingilot.K48.com.
20   IN  PTR  tirion.K48.com.
21   IN  PTR  valmar.K48.com.
22   IN  PTR  lindon.K48.com.

#Tirion (Validasi dan restart)
named-checkzone 3.235.192.in-addr.arpa /etc/bind/db.192.235.3
named-checkconf
service bind9 restart

#Valmar

nano /etc/bind/named.conf.local

zone "3.235.192.in-addr.arpa" {
    type slave;
    file "/etc/bind/db.192.235.3";
    masters { 192.235.3.20; };  
};

named-checkconf
service bind9 restart

#Klien (Verifikasi reverse look up)
host 192.235.3.2
host 192.235.3.11
host 192.235.3.10

