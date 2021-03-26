# soal-shift-sisop-modul-1-F01-2021
## File .sh
- [Soal 1](https://github.com/azhar416/soal-shift-sisop-modul-1-F01-2021/tree/main/soal1)
- [Soal 2](https://github.com/azhar416/soal-shift-sisop-modul-1-F01-2021/tree/main/soal2)
- [Soal 3](https://github.com/azhar416/soal-shift-sisop-modul-1-F01-2021/tree/main/soal3)

## Soal Nomor 1
Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan daftar peringkat pesan error terbanyak yang dibuat oleh ticky dan laporan penggunaan user pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

### A. Mengumpulkan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Bantu Ryujin dalam membuat regex-nya.
untuk informasinya antara lain jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya.
Dalam kasus soal nomor 1 ini, kami menggunakan 4 pola regex

```bash
regex="(INFO |ERROR )(.*)((?=[\(])(.*))"
regex1="(?<=ERROR )(.*)(?=\ )"
regex2="(?<=[(])(.*)(?=[)])"
regex3="(?=[(])(.*)(?<=[)])"
```

dimana `regex` merupakan pola yang digunakan untuk mengambil jenis log, pesan log, dan username secara grouping. tetapi untuk kelanjutannya, regex ini tidak terpakai.
Untuk `regex1`, ini digunakan untuk mengambil pesan log yang dimana jenis lognya hanya `ERROR`.
Sementara `regex2` digunakan untuk mengambil username tanpa menggunakan tanda kurung `<username>`.
Terakhir `regex3`, digunakan untuk mengambil username dengan menggunakan tanda kurung `(<username>)`.

### B. Ryujin harus menampilkan seluruh pesan error yang muncul dan juga jumlah kemunculannya.
Untuk kasus ini, kami menggunakan `regex1` yang telah kami buat untuk menampilkan pesan log hanya dari jenis log `ERROR`.
`regex1="(?<=ERROR )(.*)(?=\ )"`
sehingga

```bash
# 1b
error_msg=$(grep -oP "$regex1" "$input" | sort)
#echo $error_msg
echo $error_msg | uniq -c | sort -nr
```

`error_msg` berfungsi untuk menyimpan data setelah `grep` dilakukan dan akan menampilkan pesan log dari jenis log `ERROR` beserta jumlahnya.

### C. Ryujin juga harus menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.
pada kasus ini, kami menggunakan regex tambahan yaitu `ERROR.*` dan `INFO.*` untuk memisahkan antara jenis log `ERROR` dan `INFO`. 

```bash
# 1c
error=$(grep -oP "ERROR.*" "$input")
#echo $error
echo ERROR
grep -oP "$regex2" <<< "$error" | sort | uniq -c
info=$(grep -oP "INFO.*" "$input")
#echo $info
echo INFO
grep -oP "$regex2" <<< "$info" | sort | uniq -c
```

Semua data `ERROR` disimpan di variabel `error` baik itu jenis log, pesan log, dan username. Begitu juga untuk yang `INFO`, data - datanya disimpan pada variabel `info`. Dan di `grep` kembali untuk mengambil username dan kemudian di count untuk menampilkan jumlahnya.

### D. Semua informasi yang didapatkan pada poin D dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

```bash
# 1d
printf "ERROR,COUNT\n" > "error_message.csv" 
grep -oP "$regex1" "$input" | sort | uniq -c | sort -nr | grep -oP "^ *[0-9]+ \K.*" | while read -r em; do
count=$(grep "$em" <<< "$error_msg" | wc -l)
#echo $em
#echo $count
printf "%s,%d\n" "$em" "$count" >> "error_message.csv"
done
```

Untuk pengerjaannya, pertama `$input` di `grep` dan dipilah datanya agar hanya log pesan dari `ERROR` dan di sorting berdasarkan jumlah keluar yg terbanyak. kemudian di `grep` lagi agar angka jumlah tadi tidak masuk. lalu di read, serta di bandingkan tiap line read tadi dengan `$error_msg` yg berisi seluruh pesan log dan dihitung banyaknya data error tersebut. `$em` merupakan string yg berisi pesan erornya dan `$count` merupakan integer dari jumlah pesan tersebut dan kemudian variabel tersebut di print dalam file `error_message.csv`.

### E. Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.

```bash
# 1e
printf "Username,INFO,ERROR\n" > "user_statistic.csv"
grep -oP "$regex3" <<< "$error" | sort | uniq | while read -r er; do
user=$(grep -oP "(?<=[(])(.*)(?=[)])" <<< "$er")
n_error=$(grep "$er" <<< "$error" | wc -l)
n_info=$(grep "$er" <<< "$info" | wc -l)
#echo $er
#echo $user
#echo $n_error
#echo $n_info
printf "%s,%d,%d\n" "$user" "$n_info" "$n_error" >> "user_statistic.csv"
done
```

untuk pengerjaannya, kami mengambil username dengan tanda `()` untuk di read. kemudian tiap user itu dibandingkan dengan `$error` untuk dihitung berapa kali `ERROR` dari user tersebut kemudian dimasukkan ke dalam variabel `$n_error` dan juga dibandingkan dengan `$info` untuk dihitung berapa kali `INFO` dari user tersebut kemudian dimasukkan ke dalam variabel `$n_info`. username yg di read tadi di `grep` kembali untuk menghilangkan tanda `()` dan dimasukkan ke dalam variabel `$user`. ketiga variabel tersebut di print ke dalam file `user_statistic.csv`.

