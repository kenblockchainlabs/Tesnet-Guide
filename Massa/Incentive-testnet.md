Required Hardware:

4 CORE

8 GB RAM

200 GB Disk

 Gunakan perintah dibawah ini untuk running:


```
wget -O massa-testnet.sh https://raw.githubusercontent.com/mdlog/testnet-mdlog/main/massa/massa-testnet.sh && chmod +x massa-testnet.sh && ./massa-testnet.sh
``` 


Input IP Adress atau server anda.


Input Pasword (sesuai selera).

Dalam proses tersebut tekan Y untuk melanjutkan proses instalasi (sebanyak 2 kali)

Setelah proses instalasi binary dari massa selesai, CTRL + C

Selanjutnya masuk kedalam folder massa-client dengan cara:


```
cd massa/massa-client
``` 

Selanjutnya eksekusi perintah:


```
./massa-client
``` 

Enter password yang sudah dibuat sebelumnya untuk masuk di folder massa-client




Setelah berada di folder massa-client jalankan perintah berikut:


```
wallet_generate_secret_key
``` 



```
wallet_info
``` 


Restore wallet:


```
wallet_add_secret_keys <your_secret_key>
``` 

```
wallet_info
``` 

Lanjud ke [https://discord.gg/massa](Link)

#testnet-faucet

![1_BNiGhv8K9Xiccfmh-hZVUw.jpeg](https://cdn.hashnode.com/res/hashnode/image/upload/v1662874436397/ZYCPIv6JJ.jpeg align="left")


Buy Roll


```
buy_rolls <address> <roll count> <fee>
``` 

contoh:

```
buy_rolls VkUQ5MA4niNBhAEP7uVf89tvPfUHcbgy6BrdLM9SAuFSyy9DE 1 0
``` 

Next


```
node_add_staking_secret_keys <your_secret_key>
``` 

konfigurasi bot discord:"

#tesnet reward



![1_csLEd6DDb4lv3dMPnoowOQ.jpeg](https://cdn.hashnode.com/res/hashnode/image/upload/v1662874691336/5P4_Lct1l.jpeg align="left")


![1_ziCV4jzQDAw5r1LcwyN_pw.jpeg](https://cdn.hashnode.com/res/hashnode/image/upload/v1662874702251/9e4xW9tXX.jpeg align="left")


Setelah itu masukkan perintah di folder massa-client dengan:


```
node_testnet_rewards_program_ownership_proof your_staking_address discord ID
``` 

Contoh:

```
node_testnet_rewards_program_ownership_proof Acffdscbsbfbsbsdbsbbbfsbsfssfbsdfsbffbdfhf 1234567890101112
``` 

kemudian di paste hasil codenya di Massa Bot discord.


Input IP adress VPS di Massa Bot

*Untuk memeriksa detail skoring Massa silahkan ketik “info” di Massa Bot.*


Untuk memeriksa kapan address dipilih untuk di staking, jalankan perintah berikut:


```
get_addresses <your_address>
``` 


*Atur firewall di VPSnya untuk mengizinkan koneksi TCP masuk pada port. Port yang digunakan adalah 31244 dan 31245. Lihat vidio tutorial setting port dibawah (Contoh Menggunakan VPS Azure):*

Anda juga bisa membuka port dengan perintah:


```
ufw allow 31244 && ufw allow 31245
``` 


```
ufw enable
``` 

log


```
sudo tail -f /root/massa/massa-node/logs.txt
``` 


```
systemctl restart massad
systemctl status massad
``` 


**Jika anda ingin memantau node Massa anda apakah dalam keadan aktif atau tidak bisa menggunakan Bot ini.**


[https://github.com/mdlog/testnet-mdlog/tree/main/bot](Link)
