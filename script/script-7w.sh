7-Werkudara() {
# Nomor 7 - Lanjutan (2)
echo '
options {
        directory "var/cache/bind";
        //dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

echo 'zone "baratayuda.abimanyu.f07.com"{
        type master;
        file "/etc/bind/Baratayuda/baratayuda.abimanyu.f07.com";
};'> /etc/bind/named.conf.local

mkdir -p /etc/bind/Baratayuda
cp /etc/bind/db.local /etc/bind/Baratayuda/baratayuda.abimanyu.f07.com

echo '
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.f07.com. root.baratayuda.abimanyu.f07.com. (
                        2023101101      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      baratayuda.abimanyu.f07.com.
@               IN      A       10.55.3.3       ; IP Abimanyu
www             IN      CNAME   baratayuda.abimanyu.f07.com.
' > /etc/bind/Baratayuda/baratayuda.abimanyu.f07.com
service bind9 restart

}