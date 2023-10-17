#!/bin/bash
8-Werkudara() {
# Nomor 8
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
rjp             IN      A       10.55.3.3       ; IP Abimanyu
www.rjp         IN      CNAME   rjp.baratayuda.abimanyu.f07.com.
' > /etc/bind/Baratayuda/baratayuda.abimanyu.f07.com
service bind9 restart

}