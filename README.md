# Laporan Resmi Praktikum Jaringan Komputer Modul 2 2023

Repository in ***Bahasa***

**Topic :**

Domain Name System (DNS) & Web Server

**Identity :** 

Kelompok B02 -
Jaringan Komputer (F) </br>
*Insitut Teknologi Sepuluh Nopember*

**Authors :**
| Name                              | Student ID |
| ----------------------------------|------------|
| Abdurrahman Farimza               | 5025201125 |
| Muhammad Zikri Ramadhan           | 5025211085 |
| Adrian Aziz Santoso               | 5025221229 |

# List of Contents
- [Preparation](#preparation)
  - [Topology](#topology)
  - [Node Config](#node-config)
  - [Install & Setup](#install--setup)
- [Question 1 - *DNS*](#question-1---dns)
  - [Script Solution](#script-solution)
  - [Test Result](#test-result)
- [Question 2 - *DNS*](#question-2---dns)
  - [Script Solution](#script-solution-1)
  - [Test Result](#test-result-1)
- [Question 3 - *DNS*](#question-3---dns)
  - [Script Solution](#script-solution-2)
  - [Test Result](#test-result-2)
- [Question 4 - *DNS*](#question-4---dns)
  - [Script Solution](#script-solution-3)
  - [Test Result](#test-result-3)
- [Question 5 - *DNS*](#question-5---dns)
  - [Script Solution](#script-solution-4)
  - [Test Result](#test-result-4)
- [Question 6 - *DNS*](#question-6---dns)
  - [Script Solution](#script-solution-5)
  - [Test Result](#test-result-5)
- [Question 7 - *DNS*](#question-7---dns)
  - [Script Solution](#script-solution-6)
  - [Test Result](#test-result-6)
- [Question 8 - *DNS*](#question-8---dns)
  - [Script Solution](#script-solution-7)
  - [Test Result](#test-result-7)
- [Question 9 - *Web Server*](#question-9---web-server)
  - [Script Solution](#script-solution-8)
  - [Test result](#test-result-8)
- [Question 10 - *Web Server*](#question-10---web-server)
  - [Script Solution](#script-solution-9)
  - [Test Result](#test-result-9)
- [Question 11 - *Web Server*](#question-11---web-server)
  - [Script Solution](#script-solution-10)
  - [Test Result](#test-result-10)
- [Question 12 - *Web Server*](#question-12---web-server)
  - [Script Solution](#script-solution-11)
  - [Test Result](#test-result-11)
- [Question 13 - *Web Server*](#question-13---web-server)
  - [Script Solution](#script-solution-12)
  - [Test Result](#test-result-12)
- [Question 14 - *Web Server*](#question-14---web-server)
  - [Script Solution](#script-solution-13)
  - [Test Result](#test-result-13)
- [Question 15 - *Web Server*](#question-15---web-server)
  - [Script Solution](#script-solution-14)
  - [Test Result](#test-result-14)
- [Question 16 - *Web Server*](#question-16---web-server)
  - [Script Solution](#script-solution-15)
  - [Test Result](#test-result-15)
- [Question 17 - *Web Server*](#question-17---web-server)
  - [Script Solution](#script-solution-16)
  - [Test Result](#test-result-16)
- [Question 18 - *Web Server*](#question-18---web-server)
  - [Script Solution](#script-solution-17)
  - [Test Result](#test-result-17)
- [Question 19 - *Web Server*](#question-19---web-server)
  - [Script Solution](#script-solution-18)
  - [Test Result](#test-result-18)
- [Question 20 - *Web Server*](#question-20---web-server)
  - [Script Solution](#script-solution-19)
  - [Test Result](#test-result-19)
- [Obstacle](#obstacle)

# Preparation
> Must be known before starting configuration
## Network Topology
> *Using Topology number 6*

![imgTopology](resources/doc-images/topology.png)

## Node Configuration
- **Router** 
  - Pandudewanata
  ```
  auto eth0
  iface eth0 inet dhcp

  auto eth1
  iface eth1 inet static
      address 192.179.1.1
      netmask 255.255.255.0

  auto eth2
  iface eth2 inet static
      address 192.179.2.1
      netmask 255.255.255.0

  auto eth3
  iface eth3 inet static
      address 192.179.3.1
      netmask 255.255.255.0

  ```

**Switch 1**
- **Client**
  - Nakula
  ```
  auto eth0
  iface eth0 inet static
        address 192.179.1.2
	    netmask 255.255.255.0
	    gateway 192.179.1.1
  ```
  - Sadewa
  ```
  auto eth0
  iface eth0 inet static
	    address 192.179.1.3
        netmask 255.255.255.0
        gateway 192.179.1.1
  ```
- DNS
  - Yudhistira (Master)
  ```
  auto eth0
  iface eth0 inet static
        address 192.179.1.4
        netmask 255.255.255.0
        gateway 192.179.1.1
  ```
  - Werkudara (Slave)
  ```
  auto eth0
  iface eth0 inet static
        address 192.179.1.5
        netmask 255.255.255.0
        gateway 192.179.1.1
  ```

**Switch 2**
- **Load Balancer**
  - Arjuna
  ```
  auto eth0
  iface eth0 inet static
        address 192.179.2.2
        netmask 255.255.255.0
        gateway 192.179.2.1
  ```

**Switch 3**
- **Web Server**
  - Prabukusuma
  ```
  auto eth0
  iface eth0 inet static
        address 192.179.3.2
        netmask 255.255.255.0
        gateway 192.179.3.1
  ```
  - Abimanyu
  ```
  auto eth0
  iface eth0 inet static
        address 192.179.3.3
        netmask 255.255.255.0
        gateway 192.179.3.1
  ```
  - Wisanggeni
  ```
  auto eth0
  iface eth0 inet static
        address 192.179.3.4
        netmask 255.255.255.0
        gateway 192.179.3.1
  ```

## Install & Setup
- **Router (Pandudewanata)**

```sh
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.179.0.0/16
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
```

- **DNS Master & Slave (Yudhistira & Werkudara)**

```sh
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y      
```

- **Client (Nakula & Sadewa)**

```sh
echo '
nameserver 192.179.1.4 # IP Yudhistira
nameserver 192.179.1.5 # IP Werkudara
nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
```

- **Web Server Nginx**

```sh
apt install nginx php php-fpm -y
```

- **Web Server Apache2**

```sh
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
apt-get install nginx -y
service nginx start
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
service apache2 start
apt-get install wget -y
apt-get install unzip -y
apt-get install php -y
echo -e "\n\nPHP Version:"
php -v
```

- **Zip Download & Unzip Web Server Resources**

```sh
wget -O '/var/www/abimanyu.b02.com' 'https://drive.usercontent.google.com/download?id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc'
unzip -o /var/www/abimanyu.b02.com -d /var/www/
mv /var/www/abimanyu.yyy.com /var/www/abimanyu.b02
rm /var/www/abimanyu.b02.com
rm -rf /var/www/abimanyu.yyy.com

wget -O '/var/www/parikesit.abimanyu.b02.com' 'https://drive.usercontent.google.com/download?id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS'
unzip -o /var/www/parikesit.abimanyu.b02.com -d /var/www/
mv /var/www/parikesit.abimanyu.yyy.com /var/www/parikesit.abimanyu.b02
rm /var/www/parikesit.abimanyu.b02.com
rm -rf /var/www/parikesit.abimanyu.yyy.com
mkdir /var/www/parikesit.abimanyu.b02/secret

wget -O '/var/www/rjp.baratayuda.abimanyu.b02.com' 'https://drive.usercontent.google.com/download?id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6'
unzip -o /var/www/rjp.baratayuda.abimanyu.b02.com -d /var/www/
mv /var/www/rjp.baratayuda.abimanyu.yyy.com /var/www/rjp.baratayuda.abimanyu.b02
rm /var/www/rjp.baratayuda.abimanyu.b02.com
rm -rf /var/www/rjp.baratayuda.abimanyu.yyy.com
```

--- 
## Question 1 - *DNS*
> Yudhistira akan digunakan sebagai DNS Master, Werkudara sebagai DNS Slave, Arjuna merupakan Load Balancer yang terdiri dari beberapa Web Server yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Buatlah topologi nya!

Setelah membuat Topologi *Node* dan konfigurasi *Node* dengan menggunakan GNS3, langkah selanjutnya yaitu melakukan setup pada *Node router* (Pandudewanata) dan juga pada *Node client* (Nakula & Sadewa).

### Script Solution
> Testing Node
```sh
ping google.com -c 3
```

### Test Result
***Nakula*** :
![p-gglNakula](resources/doc-images/p-ggl-Nakula.png)

***Sadewa*** :
![p-gglSadewa](resources/doc-images/p-ggl-Sadewa.png)


## Question 2 - *DNS*
> Buatlah website utama pada node arjuna dengan akses ke **arjuna.yyy.com** dengan alias **www.arjuna.yyy.com** dengan yyy merupakan kode kelompok!

Dilakukan setup terlebih dahulu pada *Node* Yudhistira (DNS Master). Setelah itu dilanjut dengan pembuatan domain yang tertera pada script berikut.

### Script Solution
- Node Yudhistira

```sh
echo 'zone "arjuna.b02.com" {
        type master;
        file "/etc/bind/praktikum-jarkom/arjuna.b02.com";
};'

mkdir /etc/bind/praktikum-jarkom

echo "
\$TTL    604800
@       IN      SOA     arjuna.b02.com. root.arjuna.b02.com. (
                        2023101101      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      arjuna.b02.com.
@               IN      A       192.179.2.2 ; IP Arjuna
www             IN      CNAME   arjuna.b02.com.
" > /etc/bind/praktikum-jarkom/arjuna.b02.com

service bind9 restart
```

Setelah itu melakukan *setup* yaitu menghapus *namserver 192.168.122.1* atau *nameserver router* dan menambahkan *nameserver IP Node Yudhistira* dalam file **/etc/resolv.conf** pada *Node Client* (Nakula / Sadewa) seperti berikut :

```
nameserver 192.179.1.4
```

Dan setelah itu dapat dibuktikan dengan melakukan **Ping** dan `host` melalui **CNAME** pada domain yang telah dibuat 

```sh
ping arjuna.b02.com -c 3
ping www.arjuna.b02.com -c 3
host -t CNAME www.arjuna.b02.com
```

### Test Result
Test tanpa **www**

![domArjuna](resources/doc-images/2-1.png)

Test menggunakan **www**

![domWwwArjuna](resources/doc-images/2-2.png)

Test Alias dari **www**

![cnameArjuna](resources/doc-images/2-3.png)


## Question 3 - *DNS*
> Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke **abimanyu.yyy.com** dan alias **www.abimanyu.yyy.com**!

Langkah-langkah implementasi yang dilakukan sama seperti *Question 2*, perbedaannya hanya terletak pada nama *domain*

### Script Solution
- Node Yudhistira

```sh
echo 'zone "abimanyu.b02.com" {
        type master;
        file "/etc/bind/praktikum-jarkom/abimanyu.b02.com";
};'

echo "
\$TTL    604800
@       IN      SOA     abimanyu.b02.com. root.abimanyu.b02.com. (
                        2023101101      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      abimanyu.b02.com.
@               IN      A       192.179.3.3 ; IP Abimanyu
www             IN      CNAME   abimanyu.b02.com.
" > /etc/bind/praktikum-jarkom/abimanyu.b02.com

service bind9 restart
```

Setelah itu, dikarenakan *nameserver* masih menggunakan *IP Node Yudhistira* maka langkah selanjutnya yaitu langsung dibuktikan dengan melakukan **Ping** dan `host` melalui **CNAME** pada domain

```sh
ping abimanyu.b02.com -c 3
ping www.abimanyu.b02.com -c 3
host -t CNAME www.abimanyu.b02.com
```

### Test Result
Test tanpa **www**

![domAbimanyu](resources/doc-images/3-1.png)

Test menggunakan **www**

![domWwwAbimanyu](resources/doc-images/3-2.png)

Test Alias dari **www**

![cnameAbimanyu](resources/doc-images/3-3.png)


## Question 4 - *DNS*
> Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain **parikesit.abimanyu.yyy.com** yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu!

Dalam membuat *subdomain* pada domain *abimanyu.yyy.com*, perlu menambahkan baris baru dengan nama **parikesit** pada file *abimanyu.b02.com* dengan type **A** 

### Script Solution
- Node Yudhistira

```sh
echo "
\$TTL    604800
@       IN      SOA     abimanyu.b02.com. root.abimanyu.b02.com. (
                        2023101101      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      abimanyu.b02.com.
@               IN      A       192.179.3.3 ; IP Abimanyu
www             IN      CNAME   abimanyu.b02.com.
parikesit       IN      A       192.179.3.3 ; IP Abimanyu
" > /etc/bind/praktikum-jarkom/abimanyu.b02.com

service bind9 restart
```

Setelah itu, langkah selanjutnya masih sama dengan *Question 2 / 3*, yaitu langsung dibuktikan melalui **Ping**

```sh
ping parikesit.abimanyu.b02.com -c 3
```

### Test Result

![parikesit](resources/doc-images/4.png)

## Question 5 - *DNS*
> Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)!

Sebelum melakukan reverse domain, langkah pertama adalah perlu untuk mengetahui IP dari *Node* Abimanyu. Karena IP Abimanyu adalah 192.179.3.3, maka kita perlu mengubahnya menjadi 3.3.179.192. 

### Script Solution

Setelah mengetahui IP dari *Node* Abimanyu, kita perlu mengedit file **/etc/bind/named.conf.local** dengan menambahkan 3 byte awal dari IP *Node* Abimanyu seperti berikut
- Node Yudhistira

```sh
echo 'zone "3.179.192.in-addr.arpa" { 
        type master;
        file "/etc/bind/praktikum-jarkom/3.179.192.in-addr.arpa";
};' > /etc/bind/named.conf.local
```

Dan dilanjut dengan meng-copy file **db.local** ke-dalam folder **praktikum-jarkom** dan merubah namanya menjadi **/etc/bind/jarkom/3.179.192.in-addr.arpa**. Setlah itu mengeditnya menjadi seperti berikut 

```sh
echo "
\$TTL    604800
@       IN      SOA     abimanyu.b02.com. root.abimanyu.b02.com. (
                        2023101101      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
3.179.192.in-addr.arpa.   IN      NS      abimanyu.b02.com.
3                       IN      PTR     abimanyu.b02.com.
" > /etc/bind/praktikum-jarkom/3.179.192.in-addr.arpa

service bind9 restart
```

Untuk mengecek apakah konfigurasi sudah benar atau belum, lakukan perintah berikut 

```sh
apt-get update
apt-get install dnsutils
```

Pastikan nameserver di **/etc/resolv.conf** pada *Node Yudhistira* telah dikembalikan sama dengan nameserver dari **Pandudewanata** 

Setelah itu, testing dapat dilakukan sama seperti pada *Question 2 / 3 / 4* yaitu pada *Node Client* dengan memasukkan command berikut

```sh
host -t PTR 192.179.3.3
```

### Test Result

![ptrIP](resources/doc-images/5.png)


## Question 6 - *DNS*
> Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

Dalam membuat DNS Slave, kita memerlukan beberapa konfigurasi pada `DNS Master` dan `DNS Slave (Node Werkudara)`

### Script Solution
Langkah awal adalah menambahkan *nofity, also-notify dan allow-transfer* agar memberikan izin kepada *IP* yang dituju
- Node Yudhistira

```sh
echo 'zone "arjuna.b02.com" {
        type master;
        notify yes;
        also-notify { 192.179.1.5; }; // IP Werkudara
        allow-transfer { 192.179.1.5; }; // IP Werkudara
        file "/etc/bind/praktikum-jarkom/arjuna.b02.com";
};

zone "abimanyu.b02.com" {
        type master;
        notify yes;
        also-notify { 192.179.1.5; }; // IP Werkudara
        allow-transfer { 192.179.1.5; }; // IP Werkudara
        file "/etc/bind/praktikum-jarkom/abimanyu.b02.com";
};

zone "3.179.192.in-addr.arpa" { 
        type master;
        file "/etc/bind/praktikum-jarkom/3.179.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

service bind9 restart
service bind9 stop // Stop untuk testing Slave
```

- Node Werkudara (Slave)

Membuat **type slave** pada zone dari *domain* dan mengubah *path file*

```sh
echo 'zone "arjuna.b02.com" {
        type slave;
        masters { 192.179.1.4; }; // IP Yudhistira
        file "/var/lib/bind/arjuna.b02.com";
};

zone "abimanyu.b02.com" {
        type slave;
        masters { 192.179.1.4; }; // IP Yudhistira
        file "/var/lib/bind/abimanyu.b02.com";
};' > /etc/bind/named.conf.local

service bind9 restart
```

Setelah itu, untuk membuktikan *Slave* berhasil atau tidak, perlu ditambahkan `IP Werkudara` pada **/etc/resolv.conf** didalam *Node Client*
```
nameserver 192.179.1.5
```

Jika sudah, testing dapat dilakukan dengan melakukan **Ping** pada domain yang telah dibuat seperti `Arjuna` dan `Abimanyu`

```sh
ping arjuna.b02.com -c 3
ping abimanyu.b02.com -c 3
```

### Test Result
Start bind9 **Werkudara**

![strWerku](resources/doc-images/6-1.png)

Stop bind9 **Yudhistira**

![stpYudhi](resources/doc-images/6-2.png)

Test domain **Arjuna**

![slaveArjuna](resources/doc-images/6-3.png)

Test domain **Abimanyu**

![slaveAbimanyu](resources/doc-images/6-4.png)


## Question 7 - *DNS*
> Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu **baratayuda.abimanyu.yyy.com** dengan alias **www.baratayuda.abimanyu.yyy.com** yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

Dalam membuat Delegasi subdomain, diperlukan beberapa configurasi pada `DNS Master` dan `DNS Slave`. Kita juga memerlukan bantuan ``allow-query { any; };`` pada `DNS Master dan Slave. Serta kita memerlukan ``NS`` karena NS digunakan untuk delegasi zona DNS untuk menggunakan authoritative name server yang diberikan

### Script Solution
Perlu menambahkan ``ns1     IN      A       192.179.1.5     ; IP Werkudara`` agar mendapatkan authoritative terhadap Werkudara. Kita juga perlu mengaktifkan ``allow-query { any; };`` pada `DNS Master`. Dan juga perlu untuk mengedit **/etc/bind/named.conf.local** 
- Node Yudhistira

```sh
echo '
$TTL    604800
@       IN      SOA     abimanyu.b02.com. root.abimanyu.b02.com. (
                        2023101101      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      abimanyu.b02.com.
@               IN      A       192.179.3.3 ; IP Abimanyu
www             IN      CNAME   abimanyu.b02.com.
parikesit       IN      A       192.179.3.3 ; IP Abimanyu
ns1             IN      A       192.179.1.5 ; IP Werkudara
baratayuda      IN      NS      ns1
' > /etc/bind/praktikum-jarkom/abimanyu.b02.com

echo '
options {
        directory "var/cache/bind";
        //dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

echo 'zone "abimanyu.b02.com" {
        type master;
        file "/etc/bind/praktikum-jarkom/abimanyu.b02.com";
        allow-transfer { 192.179.1.5; }; // IP Werkudara
};

zone "3.179.192.in-addr.arpa" { 
        type master;
        file "/etc/bind/praktikum-jarkom/3.179.192.in-addr.arpa";
};' > /etc/bind/named.conf.local

service bind9 restart 
```

- Node Werkudara

Dan juga perlu setup juga pada *Node Werkudara* untuk mengarahkan `zone` ke `DNS Master` agar authoritative tadi dapat jalan. Kita juga perlu mengaktifkan ``allow-query { any; };`` pada `DNS Slave`

```sh
echo '
options {
        directory "var/cache/bind";
        //dnssec-validation auto;
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

echo 'zone "baratayuda.abimanyu.b02.com"{
        type master;
        file "/etc/bind/Baratayuda/baratayuda.abimanyu.b02.com";
};'> /etc/bind/named.conf.local

mkdir -p /etc/bind/Baratayuda
cp /etc/bind/db.local /etc/bind/Baratayuda/baratayuda.abimanyu.b02.com

echo '
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.b02.com. root.baratayuda.abimanyu.b02.com. (
                        2023101101      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      baratayuda.abimanyu.b02.com.
@               IN      A       192.179.3.3       ; IP Abimanyu
www             IN      CNAME   baratayuda.abimanyu.b02.com.
' > /etc/bind/Baratayuda/baratayuda.abimanyu.b02.com

service bind9 restart
```

Setelah semua berhasil di-setup, untuk melakukan testing cukup melakukan **Ping** pada `baratayuda.abimanyu.b02.com` atau `www.baratayuda.abimanyu.b02.com` dan juga Alias dapat dilihat dengan menjalankan `host` melalui **CNAME**

```sh
ping baratayuda.abimanyu.b02.com -c 3
ping www.baratayuda.abimanyu.b02.com -c 3
host -t CNAME www.baratayuda.abimanyu.b02.com 
```

### Test Result
Test tanpa **www**

![baratayuda](resources/doc-images/7-1.png)

Test menggunakan **www**

![baratayudaWWW](resources/doc-images/7-2.png)

Test Alias dari **www**

![cnameBarata](resources/doc-images/7-3.png)


## Question 8 - *DNS*
> Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses **rjp.baratayuda.abimanyu.yyy.com** dengan alias **www.rjp.baratayuda.abimanyu.yyy.com** yang mengarah ke Abimanyu.

Dikarenakan sebelumnya telah melakukan ``delegasi`` terhadap `DNS Slave` dan sekarang diberi perintah untuk melakukan subdomain terhadap ``delegasi domain`` tadi.

### Script Solution
Langkah yang dilakukan yaitu perlu untuk melakukan penambahan pada `Werkudara / DNS Slave` sebagai berikut
```
rjp             IN      A       192.179.3.3     ; IP Abimanyu
www.rjp         IN      CNAME   rjp.baratayuda.abimanyu.b02.com.
```

- Node Werkudara

```sh
echo '
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.b02.com. root.baratayuda.abimanyu.b02.com. (
                        2023101101      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      baratayuda.abimanyu.b02.com.
@               IN      A       192.179.3.3       ; IP Abimanyu
www             IN      CNAME   baratayuda.abimanyu.b02.com.
rjp             IN      A       192.179.3.3       ; IP Abimanyu
www.rjp         IN      CNAME   rjp.baratayuda.abimanyu.b02.com.
' > /etc/bind/Baratayuda/baratayuda.abimanyu.b02.com

service bind9 restart
```

Setelah berhasil ditambahkan dan restart bind9, untuk melakukan testing cukup dengan melakukan **Ping** pada `rjp.baratayuda.abimanyu.b02.com` atau `www.rjp.baratayuda.abimanyu.b02.com` dan juga Alias dapat dilihat dengan menjalankan **CNAME**

```sh
ping rjp.baratayuda.abimanyu.b02.com -c 3
ping www.rjp.baratayuda.abimanyu.b02.com -c 3
host -t CNAME www.rjp.baratayuda.abimanyu.b02.com
```

### Test Result
Test tanpa **www**

![rjpbaratayuda](resources/doc-images/8-1.png)

Test menggunakan **www**

![rjpbaratayudaWWW](resources/doc-images/8-2.png)

Test Alias dari **www**

![cnamerjpBarata](resources/doc-images/8-3.png)


## Question 9 - *Web Server*
> Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker (yang juga menggunakan nginx sebagai webserver) yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.

Untuk melakukan load balancer, kita dapat melakukan konfigurasi pada node Arjuna sebagai load balancer, node : Prabakusuma, Abimanyu, dan Wisanggeni sebagai workernya. Konfigurasi ini dapat dijadikan ke dalam satu script bash, namun dibedakan untuk setiap fungsinya
### Script Solution
Pada node Arjuna, dapat melakukan konfigurasi berikut (Beberapa perintah sudah sempat disinggung sebelumnya pada bagian Preparation, namun ditulis kembali).

```sh
echo -e '
nameserver 192.168.122.1
nameserver 192.179.1.4 # IP Yudhistira
nameserver 192.179.1.5 # IP Werkudara
' > /etc/resolv.conf

ping google.com -c 3
apt-get update
apt-get install bind9 nginx
apt-get install dnsutils -y
apt-get install lynx -y
```

Setelah itu, untuk load balancer pada node Arjuna, dapat dilakukan melalui konfigurasi berikut

```sh
echo '
 upstream myweb  {
 	server 192.179.3.2; #IP Prabakusuma
 	server 192.179.3.3; #IP Abimanyu
 	server 192.179.3.4; #IP Wisanggeni
 }

 server {
 	listen 80;
 	server_name arjuna.b02.com www.arjuna.b02.com;

 	location / {
 	proxy_pass http://myweb;
 	}
 }
' > /etc/nginx/sites-available/lb-arjuna.b02

 ln -s /etc/nginx/sites-available/lb-arjuna.b02 /etc/nginx/sites-enabled
 service nginx restart
```

Untuk worker, pada node Prabakusuma, dapat melakukan konfigurasi berikut

```sh
echo -e '
nameserver 192.168.122.1
nameserver 192.179.1.4 # IP Yudhistira
nameserver 192.179.1.5 # IP Werkudara
' > /etc/resolv.conf
apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y
apt-get install dnsutils -y

mkdir /var/www/praktikum-jarkom

echo '
 <?php
  echo "Halo, Kamu berada di Prabakusuma";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
 server {

 	listen 80;

 	root /var/www/praktikum-jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/arjuna.b02_error.log;
 	access_log /var/log/nginx/arjuna.b02_access.log;
 }
' > /etc/nginx/sites-available/arjuna.b02

ln -s /etc/nginx/sites-available/arjuna.b02 /etc/nginx/sites-enabled
service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
```

Untuk worker, pada node Abimanyu, dapat melakukan konfigurasi berikut

```sh
echo -e '
nameserver 192.168.122.1
nameserver 192.179.1.4 # IP Yudhistira
nameserver 192.179.1.5 # IP Werkudara
' > /etc/resolv.conf
apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y
apt-get install dnsutils -y

mkdir /var/www/praktikum-jarkom

echo '
 <?php
  echo "Halo, Kamu berada di Abimanyu";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
 server {

 	listen 80;

 	root /var/www/praktikum-jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/arjuna.b02_error.log;
 	access_log /var/log/nginx/arjuna.b02_access.log;
 }
' > /etc/nginx/sites-available/arjuna.b02

ln -s /etc/nginx/sites-available/arjuna.b02 /etc/nginx/sites-enabled
service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
```

Untuk worker, pada node Wisanggeni, dapat melakukan konfigurasi berikut

```sh
echo -e '
nameserver 192.168.122.1
nameserver 192.179.1.4 # IP Yudhistira
nameserver 192.179.1.5 # IP Werkudara
' > /etc/resolv.conf
apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y
apt-get install dnsutils -y

mkdir /var/www/praktikum-jarkom

echo '
 <?php
  echo "Halo, Kamu berada di Wisanggeni";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
 server {

 	listen 80;

 	root /var/www/praktikum-jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/arjuna.b02_error.log;
 	access_log /var/log/nginx/arjuna.b02_access.log;
 }
' > /etc/nginx/sites-available/arjuna.b02

ln -s /etc/nginx/sites-available/arjuna.b02 /etc/nginx/sites-enabled
service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
```

### Test Result
Lakukan pengujian pada node client seperti Nakula. Tuliskan perintah berikut

![9 test](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/81ce7cfb-262d-402a-b765-8c49f8e6b3ef)

Maka akan diperoleh hasil sebagai berikut. Hasil ini dapat berubah-ubah jika perintah pengujian di atas dijalankan kembali

Hasil menampilkan Prabakusuma

![9a testpra](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/5aa958d4-9668-4076-8b52-4a62c2bf8f7b)

Hasil menampilkan Abimanyu

![9b testabi](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/636e51ff-274a-404b-91dc-4af362aa73a3)

Hasil menampilkan Wisanggeni

![9c testwis](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/944690fc-f96a-499d-b6bd-81c6c177270b)


## Question 10 - *Web Server*
> Kemudian gunakan algoritma **Round Robin** untuk Load Balancer pada **Arjuna**. Gunakan server_name pada soal nomor 1. Untuk melakukan pengecekan akses alamat web tersebut kemudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak. Untuk webserver di masing-masing worker wajib berjalan di port 8001-8003. Contoh **Prabakusuma:8001**, **Abimanyu:8002**, **Wisanggeni:8003** 

Setelah sebelumnya berhasil melakukan deployment pada setiap worker, untuk menerapkan **Round Robin** dan setiap worker ditentukan port-nya. Kita hanya perlu mengubah beberapa konfigurasi pada load balancer Arjuna, dan ketiga workernya.

### Script Solution
Untuk load balancer Arjuna, dapat mengubah konfigurasinya menjadi seperti berikut ini. Disini ditambahkan `:800N` pada setiap baris server worker-nya, dengan N merupakan angka 1 hingga 3 untuk membedakan port pada setiap workernya.

```sh
echo '
 upstream myweb  {
 	server 192.179.3.2:8001; #IP Prabakusuma
 	server 192.179.3.3:8002; #IP Abimanyu
 	server 192.179.3.4:8003; #IP Wisanggeni
 }

 server {
 	listen 80;
 	server_name arjuna.b02.com;

 	location / {
 	proxy_pass http://myweb;
 	}
 }
' > /etc/nginx/sites-available/lb-arjuna.b02
ln -s /etc/nginx/sites-available/lb-arjuna.b02 /etc/nginx/sites-enabled
service nginx restart
```

Adapun untuk worker-nya, terdapat tambahan keterangan terkait port yang digunakan. Pada konfigurasi ini, dapat dilihat pada baris `listen 800N`, dimana N merupakan angka menyesuaikan dengan masing-masing port worker. Disini juga ditambahkan satu perintah `echo` (echo yang ketiga) yang menampilkan pesan tambahan terkait port yang digunakan oleh setiap worker.

```sh
echo '
 <?php
  echo "Halo, Kamu berada di [Nama Worker]";
 ?>
' > /var/www/praktikum-jarkom/index.php

echo '
server {

 	listen 800N;

 	root /var/www/praktikum-jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/arjuna.b02_error.log;
 	access_log /var/log/nginx/arjuna.b02_access.log;
 }
' > /etc/nginx/sites-available/arjuna.b02

nginx_port=$(awk '/listen/ {print $2}' /etc/nginx/sites-available/arjuna.b02)
echo "
 <?php
  echo ',tepatnya di port : $nginx_port'
 ?>
" >> /var/www/praktikum-jarkom/index.php

service php7.0-fpm start
rm /etc/nginx/sites-enabled/default
service nginx restart
```

### Test Result
Lakukan pengujian pada node client seperti Nakula. Tuliskan perintah berikut

![9 test](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/81ce7cfb-262d-402a-b765-8c49f8e6b3ef)

Hasil menampilkan Prabakusuma

![10a testpra](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/4891f93e-f475-4aef-ab70-d1739397a578)

Hasil menampilkan Abimanyu

![10b testabi](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/6321a60a-dabc-4bff-ab71-14a87de0a982)

Hasil menampilkan Wisanggeni

![10c testwis](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/faf59cb5-74c8-410c-856a-f95ee681928a)


## Question 11 - *Web Server*
> Selain menggunakan Nginx, lakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server **www.abimanyu.yyy.com**. Pertama dibutuhkan web server dengan DocumentRoot pada /var/www/abimanyu.yyy

Diperlukan beberapa konfigurasi setup jika belum melakukan setup pada `Node Abimanyu`, seperti

```sh
apt-get update
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
service apache2 start
apt-get install wget -y
apt-get install unzip -y
apt-get install php -y
```

Kemudian juga menjalankan setup-setup berikut

```sh
wget -O '/var/www/abimanyu.b02.com' 'https://drive.usercontent.google.com/download?id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc'
unzip -o /var/www/abimanyu.b02.com -d /var/www/
mv /var/www/abimanyu.yyy.com /var/www/abimanyu.b02
rm /var/www/abimanyu.b02.com
rm -rf /var/www/abimanyu.yyy.com
```

### Script Solution
- Node Abimanyu

```sh
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.b02.com.conf

rm /etc/apache2/sites-available/000-default.conf

echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.b02

  ServerName abimanyu.b02.com
  ServerAlias www.abimanyu.b02.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.b02.com.conf

a2ensite abimanyu.b02.com.conf

service apache2 restart
```

Kemudian setelah itu, untuk menampilkan pada client yaitu menggunakan **lynx** yang di-install (Jangan lupa untuk menambahkan nameserver router pada saat penginstalan) 

```sh
apt-get install lynx -y
```

Setelah itu dapat langsung dijalankan dengan command berikut

```sh
lynx abimanyu.b02.com
```

### Test Result

![11](resources/doc-images/11.png)


## Question 12 - *Web Server*
> Setelah itu ubahlah agar url **www.abimanyu.yyy.com/index.php/home** menjadi **www.abimanyu.yyy.com/home**.

Untuk menyelesaikan permasalahan ini, diperlukan bantuan `Directory` sebagai tools untuk rewrite Indexes agar dapat melakukan Alias pada *domain*. Penerapan nya sebagai berikut

```
<Directory /var/www/abimanyu.b02/index.php/home>
  Options +Indexes
</Directory>

Alias "/home" "/var/www/abimanyu.b02/index.php/home"
```

### Script Solution
- Node Abimanyu

```sh
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/abimanyu.b02
  ServerName abimanyu.b02.com
  ServerAlias www.abimanyu.b02.com

  <Directory /var/www/abimanyu.b02/index.php/home>
          Options +Indexes
  </Directory>

  Alias "/home" "/var/www/abimanyu.b02/index.php/home"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/abimanyu.b02.com.conf

service apache2 restart
```

Setelah itu, lakukan testing dengan menjalankan command berikut pada *Node Client*

```sh
lynx abimanyu.b02.com/home
```

### Test Result

![12](resources/doc-images/12.png)


## Question 13 - *Web Server*
> Selain itu, pada subdomain **www.parikesit.abimanyu.yyy.com**, DocumentRoot disimpan pada /var/www/parikesit.abimanyu.yyy

Dalam menyelesaikan permasalahan tersebut, disini kita sebelumnya diperlukan beberapa konfigurasi setup seperti berikut 

```sh
wget -O '/var/www/parikesit.abimanyu.b02.com' 'https://drive.usercontent.google.com/download?id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS'
unzip -o /var/www/parikesit.abimanyu.b02.com -d /var/www/
mv /var/www/parikesit.abimanyu.yyy.com /var/www/parikesit.abimanyu.b02
rm /var/www/parikesit.abimanyu.b02.com
rm -rf /var/www/parikesit.abimanyu.yyy.com
mkdir /var/www/parikesit.abimanyu.b02/secret
```

Dan dilanjut dengan melakukan konfigurasi pada `ServerName` dan `ServerAlias`
### Script Solution

```sh
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.b02
  ServerName parikesit.abimanyu.b02.com
  ServerAlias www.parikesit.abimanyu.b02.com

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.b02.com.conf

a2ensite parikesit.abimanyu.b02.com.conf

service apache2 restart
```

Setelah itu, testing dilakukan pada *Node Client* dengan menjalankan command berikut 

```sh
lynx parikesit.abimanyu.b02.com
```

### Test Result

![13](resources/doc-images/13.png)


## Question 14 - *Web Server*
> Pada subdomain tersebut folder /public hanya dapat melakukan directory listing sedangkan pada folder /secret tidak dapat diakses *(403 Forbidden)*.

Dalam menyelesaikan permasalahan tersebut cukup simple, prinsipnya jika kita mau mengizinkan **public** agar dapat melakukan *directory listing* kita menggunakan **Options +Indexes**. Sedangkan agar suatu folder tidak dapat di akses (*forbidden*), kita dapat menggunakan **Option -Indexes**.

### Script Solution
- Node Abimanyu

```sh
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.b02
  ServerName parikesit.abimanyu.b02.com
  ServerAlias www.parikesit.abimanyu.b02.com

  <Directory /var/www/parikesit.abimanyu.b02/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.b02/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.b02/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.b02/secret"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.b02.com.conf

service apache2 restart
```

Setelah itu, untuk membuktikan nya cukup dengan memasukkan command berikut pada *Node Client*

```sh
lynx parikesit.abimanyu.b02.com/public
lynx parikesit.abimanyu.b02.com/secret
```

### Test Result
Test **public**

![pariPublic](resources/doc-images/14-1.png)

Test **secret**

![pariSecret](resources/doc-images/14-2.png)

Laman **secret** setelah *alert*

![nextPariSecret](resources/doc-images/14-3.png)


## Question 15 - *Web Server*
> Buatlah kustomisasi halaman error pada folder /error untuk mengganti error kode pada Apache. Error kode yang perlu diganti adalah 404 Not Found dan 403 Forbidden

Dalam membuat page *error html*, didapatkan dari file *resources* yang telah diberikan, untuk detailnya ada pada folder **parikesit.abimanyu.b02.com/public/error/.** Disana terdapat 2 file yaitu **403.html** dan **404.html**.</br>
Untuk menyelesaikan-nya juga menggunakan **ErrorDocument** yang berfungsi melakukan *redirect* terhadap file yang diinginkan ketika mendapatkan masalah ketika mengakses *domain* yang telah ada sebelumnya. Sehingga penerapan konfigurasinya dengan menambahkan berikut 

```
ErrorDocument 404 /error/404.html
ErrorDocument 403 /error/403.html
```

### Script Solution
- Node Abimanyu

```sh
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.b02
  ServerName parikesit.abimanyu.b02.com
  ServerAlias www.parikesit.abimanyu.b02.com

  <Directory /var/www/parikesit.abimanyu.b02/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.b02/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.b02/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.b02/secret"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.b02.com.conf

service apache2 restart
```

Setelah itu, untuk membuktikan **custom error** cukup dengan menjalankan command berikut pada *Node Client*

```sh
lynx parikesit.abimanyu.b02.com/testerror
lynx parikesit.abimanyu.b02.com/secret
```

### Test Result
Test pada laman **404 Error**

![error1](resources/doc-images/15-1.png)

Laman **404 Error** setelah *alert*

![nextError](resources/doc-images/15-2.png)

Test pada laman **403 Forbidden**

![forbidden1](resources/doc-images/15-3.png)

Laman **403 Forbidden** setelah *alert*

![nextSecret](resources/doc-images/15-4.png)


## Question 16 - *Web Server*
> Buatlah suatu konfigurasi virtual host agar file asset **www.parikesit.abimanyu.yyy.com/public/js** menjadi **www.parikesit.abimanyu.yyy.com/js** 

Agar **www.parikesit.abimanyu.b02.com/public/js** dapat diakses hanya dengan masuk ke **www.parikesit.abimanyu.b02.com/js**, kita dapat menambahkan `Alias` ke dalam file `parikesit.abimanyu.b02.com.conf`

### Script Solution
Pada file `parikesit.abimanyu.b02.com.conf` tambahkan baris `Alias "/js" "/var/www/parikesit.abimanyu.b02/public/js"` seperti ini

```sh
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.b02
  ServerName parikesit.abimanyu.b02.com
  ServerAlias www.parikesit.abimanyu.b02.com

  <Directory /var/www/parikesit.abimanyu.b02/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.b02/secret>
          Options -Indexes
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.b02/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.b02/secret"
  Alias "/js" "/var/www/parikesit.abimanyu.b02/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.b02.com.conf
```
Setelah itu lakukan perintah `service apache2 restart`

### Test Result
Ketika dilakukan pengujian pada client node Nakula,

![16 test](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/e95ab474-6577-4bb6-a3c6-0b78b053434f)

Diperoleh hasil yang sama ketika mengakses `www.parikesit.abimanyu.b02.com/public/js`, yaitu sebagai berikut

![16a testresult](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/16ca2d14-ac3f-4140-b59e-ffd76929a3b2)

## Question 17 - *Web Server*
> Agar aman, buatlah konfigurasi agar **www.rjp.baratayuda.abimanyu.yyy.com** hanya dapat diakses melalui port 14000 dan 14400.

Untuk mengizinkan akses hanya pada port 14000 dan 14400, kita dapat mengatur port pada virtual host dan konfigurasi *Listening port* pada file `ports.conf`

### Script Solution
Setelah melakukan pengaturan awal (seperti download dari drive), kita dapat memberi keterangan `<VirtualHost *:14000 *:14400>` pada virtual host dengan membuat konfigurasi pada file `/etc/apache2/sites-available/rjp.baratayuda.abimanyu.b02.com.conf` sebagai berikut

```sh
echo -e '<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.b02
  ServerName rjp.baratayuda.abimanyu.b02.com
  ServerAlias www.rjp.baratayuda.abimanyu.b02.com

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.b02.com.conf
```

Setelah itu, kita perlu menambah `Listening Port` pada file `/etc/apache2/ports.conf`. Berikut konfigurasinya

```sh
echo -e '# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/ports.conf
```

Setelah itu, kita perlu melakukan aktivasi dan restart server Apache2

```sh
a2ensite rjp.baratayuda.abimanyu.b02.com.conf
service apache2 restart
```

### Test Result
Untuk pengujian dengan mengakses port 14000 atau 14400, diperoleh hasil sebagai berikut

![17 test](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/67cce9e0-65f9-4b84-8fcd-b532944faa85)

![17a testresult](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/c066cebe-d90a-4738-b69e-3e0f696846e8)

Adapun untuk pengujian akses dengan port yang salah, diperoleh hasil sebagai berikut

![17b testnotvalid](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/8569a852-f288-41cb-9615-4c7f21e39b22)

![17c testnotvalidresult](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/e257116c-9a66-41e4-beb0-2c7e115e4936)

## Question 18 - *Web Server*
> Untuk mengaksesnya buatlah autentikasi username berupa “Wayang” dan password “baratayudayyy” dengan yyy merupakan kode kelompok. Letakkan DocumentRoot pada /var/www/rjp.baratayuda.abimanyu.yyy

Untuk autentikasi username dan password, kita dapat menambahkan pengaturan seperti `AuthType`, `AuthName`, `AuthUserFile`, dan `Require valid-user` pada pengaturan `<Directory /x> ... </Directory>` di dalam file `/etc/apache2/sites-available/rjp.baratayuda.abimanyu.b02.com.conf`.

### Script Solution
Untuk konfigurasinya adalah sebagai berikut

```sh
echo -e '<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.b02
  ServerName rjp.baratayuda.abimanyu.b02.com
  ServerAlias www.rjp.baratayuda.abimanyu.b02.com

  <Directory /var/www/rjp.baratayuda.abimanyu.b02>
          AuthType Basic
          AuthName "Restricted Content"
          AuthUserFile /etc/apache2/.htsecure
          Require valid-user
  </Directory>

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.b02.com.conf
```

Setelah itu, dapat menjalankan perintah berikut

```sh
htpasswd -c -b /etc/apache2/.htsecure Wayang baratayudab02
```

dimana `-c` berarti `created`, `-b` berarti fungsi `bcrypt` untuk mengubah password menjadi sebuah hash. Lalu `Wayang` sebagai username dan `baratayudab02` sebagai password. Setelah itu lakukan aktivasi dan restart apache2 server.

```sh
a2ensite rjp.baratayuda.abimanyu.b02.com.conf
service apache2 restart
```

### Test Result
Untuk pengujian, dapat kembali mengakses `lynx rjp.baratayuda.abimanyu.b02.com:14000` atau `lynx rjp.baratayuda.abimanyu.b02.com:14400` pada node client Nakula

![17 test](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/67cce9e0-65f9-4b84-8fcd-b532944faa85)

setelah itu akan muncul pesan peringatan, yang dilanjutkan dengan tampilan untuk mengisikan username dan password autentikasi

![18a testwarning](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/0caf20db-ea4d-4734-951a-10c90ac477bd)

![18b  testuser](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/250adc0f-a3ec-456b-b02c-b1bf96d67b8f)

![18c testpass](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/26433408-9987-4f6a-9842-f6d4007479b3)

Setelah mengisikan username `Wayang` dan password `baratayudab02`, diperoleh hasil sebagai berikut

![18d testresult](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/82d8bfd8-93b6-45f2-b891-5f063e79e956)

## Question 19 - *Web Server*
> Buatlah agar setiap kali mengakses IP dari Abimanyu akan secara otomatis dialihkan ke **www.abimanyu.yyy.com** (alias)

Untuk mengakses **www.abimanyu.b02.com** dengan melalui IP Abimanyu, diperlukan sebuah `Redirect` ke **www.abimanyu.b02.com**. Kita dapat memasukkan konfigurasi ini ke dalam `000-default.conf` yang merupakan pengaturan *default* dari service Apache
### Script Solution
Berikut konfigurasinya

```sh
echo -e '<VirtualHost *:80>
    ServerAdmin webmaster@abimanyu.b02.com
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    Redirect / http://www.abimanyu.b02.com/
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

apache2ctl configtest

service apache2 restart

# Test
# lynx 192.179.3.3
```

### Test Result
Kita dapat menjalankan pengujian sebagai berikut pada node client Nakula dengan menggunakan `lynx` ditujukan pada IP Abimanyu yaitu `192.179.3.3`

![19 test](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/6c4a3f46-6ca1-4dfc-b3d0-045b96cd3e86)

Diperoleh hasil sebagai berikut

![19a testresult](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/fe06d197-967c-4bd5-be2f-70bb3e77d43a)


## Question 20 - *Web Server*
> Karena website **www.parikesit.abimanyu.yyy.com** semakin banyak pengunjung dan banyak gambar gambar random, maka ubahlah request gambar yang memiliki substring “abimanyu” akan diarahkan menuju abimanyu.png.

Untuk menjawab soal ini, kita perlu mengatur pemetaan URL dengan bantuan `a2enmod rewrite`. 

### Script Solution
Berikut konfigurasinya

Pertama, kita perlu menjalankan perintah

```sh
a2enmod rewrite
```

Setelah itu, kita menjalankan pengaturan untuk ketentuan `Rewrite`-nya.

```sh
echo 'RewriteEngine On
RewriteCond %{REQUEST_URI} ^/public/images/(.*)(abimanyu)(.*\.(png|jpg))
RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
RewriteRule abimanyu http://parikesit.abimanyu.b02.com/public/images/abimanyu.png$1 [L,R=301]' > /var/www/parikesit.abimanyu.b02/.htaccess
```

Berikut keterangan terkait konfigurasi kode di atas

`RewriteEngine On`: Ini mengaktifkan mod_rewrite untuk server web. Tanpa baris ini, aturan pemetaan ulang URL tidak akan diterapkan.

`RewriteCond %{REQUEST_URI} ^/public/images/(.*)(abimanyu)(.*\.(png|jpg))`: Ini adalah kondisi pertama yang memeriksa apakah URL memenuhi pola tertentu. Kondisi ini memeriksa apakah URL dimulai dengan /public/images/ diikuti oleh teks apa pun, kemudian abimanyu, kemudian teks lagi, dan diakhiri dengan .png atau .jpg.

`RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png`: Ini adalah kondisi kedua yang memeriksa apakah URL tidak mengarah ke /public/images/abimanyu.png. Ini dirancang untuk mencegah aturan rewrite diterapkan jika URL sudah mengarah ke gambar abimanyu.png.

`RewriteRule abimanyu http://parikesit.abimanyu.b02.com/public/images/abimanyu.png$1 [L,R=301]`: Aturan pemetaan ulang ini digunakan ketika kedua kondisi di atas terpenuhi. Aturan ini akan mengarahkan URL yang memenuhi pola tersebut ke **http://parikesit.abimanyu.b02.com/public/images/abimanyu.png**, menambahkan apapun yang cocok dengan (.*) pada URL target.

Setelah itu terdapat konfigurasi *virtual host* sebagai berikut

```sh
echo -e '<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/parikesit.abimanyu.b02

  ServerName parikesit.abimanyu.b02.com
  ServerAlias www.parikesit.abimanyu.b02.com

  <Directory /var/www/parikesit.abimanyu.b02/public>
          Options +Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.b02/secret>
          Options -Indexes
  </Directory>

  <Directory /var/www/parikesit.abimanyu.b02>
          Options +FollowSymLinks -Multiviews
          AllowOverride All
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.b02/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.b02/secret"
  Alias "/js" "/var/www/parikesit.abimanyu.b02/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.b02.com.conf
```

Terakhir, jalankan perintah berikut

```sh
a2enmod rewrite
service apache2 restart
```

### Test Result
Untuk pengujian dapat dilakukan sebagai berikut, dimana kita mencoba menjalankan perintah `lynx` yang diikuti `parikesit.abimanyu.b02.com/public/images/` lalu disertai nama file. Nama file disini dapat berupa gambar, dll. Konfigurasi `Rewrite` akan melakukan penyaringan seperti ketentuan kondisi di atas.

![20 test](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/53244f71-deed-4bf7-a99c-9d6f6634dda4)

Diperoleh hasil sebagai berikut

![20a testresult](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/90ff3dfb-9b05-4775-bc93-99d5442abf64)

Jika dilakukan percobaan dengan tidak sesuai ketentuan, misalnya pada percobaan terakhir yaitu `lynx parikesit.abimanyu.b02.com/public/images/notabimanyujustmuseum.177013`, maka akan diperoleh hasil sebagai berikut

![20b testresultnotvalid](https://github.com/rafifiaan/Jarkom-Modul-2-B02-2023/assets/108170236/cb7f5bce-0b5f-4959-a416-4423036d7342)