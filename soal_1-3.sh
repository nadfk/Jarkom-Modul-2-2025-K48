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