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