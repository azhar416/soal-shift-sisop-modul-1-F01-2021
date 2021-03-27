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

## Soal Nomor 2
Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

Pada soal ini akan dicari beberapa kesimpulan dari data penjualan yang berada pada ``Laporan-TokoShiSop.tsv``. Dalam script ``soal2_generate_laporan_ihi_shisop.sh`` terdapat pengerjaan soal *2a, 2b, 2c, dan 2d*. Hasil pengerjaan soal nomor 2 ini ditampilkan pada ``hasil.txt``.
```bash
    awk ' '
```
Untuk penyelesaian soal ini digunakan ``awk`` sehingga harus mengimport ``awk`` pada awal ``shell script``.
```bash
    BEGIN{FS="\t"}
```
File ``Laporan-TokoShiSop.tsv`` berformat _**.tsv**_ sehingga file separator atau pemisah setiap kolomnya adalah *tab*. Oleh karena itu pada snippet code diatas digunakan *FS="\t"*
```bash
    export LC_ALL=C
```
Menggunakan ``LC_ALL=C`` agar bisa mengambil angka desimal yang dipisahkan oleh ``.`` dengan tepat
```bash
    awk -v maximumProfit=0
```
Command berikut digunakan untuk membuat sebuah variabel bernama maximumProfit dan diinisialisasi. Variabel tersebut didefinisikan disini agar tidak mempengaruhi proses perintah yang dibuat untuk setiap baris (hanya pada soal **2A**). Command tersebut digunakan pada soal **2A**, **2C**, dan **2D**.

### A. Mencari Row ID dengan profit percentage terbesar pada setiap transaksi (jika ada yang sama pilih Row ID terbesar)
**Soal:** Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui *Row ID* dan *Profit Percentage* terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage, yaitu:
``Profit Percentage = (Profit ÷ Cost Price) × 100``
Cost Price didapatkan dari pengurangan Sales dengan Profit. (Quantity diabaikan).
* Menghitung ``Profit Percentage``
```bash
    profitPercentage=($21/($18-$21))*100 
```
Untuk menghitung nilai **Profit Percentage** sesuai rumus diatas, maka kita harus mendapatkan value dari kolom **Profit** yang berada pada kolom ke 21 sesuai file ``Laporan-TokoShiSop.tsv`` sehingga digunakan **$21**. Sedangkan, **Cost Price** merupakan selisih antara ``Sales`` yang diakses menggunakan **$18** dengan ``Profit`` yang diakses menggunakan **$21**. Lalu, hasil pembagian dari ``Profit`` dan ``Cost Price`` dikalikan dengan 100 untuk mendapatkan persentase nya.
* Mendapatkan ``Profit Percentage`` terbesar
```bash
    if (profitPercentage>=maximumProfit){
        transactionId=$1; maximumProfit=profitPercentage
    }
```
Pada proses ini akan dilakukan perbandingan setiap barisnya antara **Profit Percentage** yang disimbolkan dengan variabel *profitPercentage* dengan suatu variabel yaitu *maximumProfit* dimana variabel ini akan menyimpan profit terbesar. Jika nilai *profitPercentage* lebih besar dari *maximumProfit* maka **Profit Percentage** terbesar akan disimpan di variabel *maximumProfit*. Lalu gunakan ``transactionId=$1`` untuk menyimpan **Row ID** paling besar.
```bash
    printf ("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%%\n", transactionId, maximumProfit)
```
Mencetak variabel *transactionID* dan *maximumProfit* sesuai format.

### B. Mencari nama-nama customer yang melakukan transaksi pada tahun 2017 di kota Albuquerque
**Soal:** Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar *nama customer* pada transaksi tahun 2017 di Albuquerque.
* Mendapatkan ``nama customer`` 
```bash
    if ($10=="Albuquerque" && $2~"2017"){
        customer[$7]=customer[$7]+1
    }
```
Menggunakan *if (condition)* untuk memeriksa apakah customer melakukan transaksi pada tahun 2017 di Albuquerque. Pada setiap baris akan dilakukan pengecekan ``City`` (pada kolom 10) dan ``Order ID`` (pada kolom 2). Disini digunakan **$10=="Albuquerque"** untuk memeriksa customer yang melakukan transaksi di Albuquerque dari kolom ``City``. Lalu, digunakan **$2~"2017"** untuk mendapatkan string yang mengandung bilangan 2017 dari kolom ``Order ID``. Disini digunakan associative array dengan nama customer sebagai index dan jumlah kemunculan nama customer sebagai value nya. Penggunaan array ini membantu karena secara otomatis tidak akan menampilkan nama customer yang sama. Nama customer ini akan disimpan di sebuah array *customer[$7]* dimana **$7** adalah kolom ``Customer Name``. Jika kondisi terpenuhi dalam  *if statement* maka baris tersebut akan dimasukkan ke array dengan index sesuai nama customer pada baris tersebut. 
```bash
    printf ("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")
    for(name in customer) printf ("%s\n", name)
```
Iterasi semua nilai pada array ``customer`` untuk menampilkan semua nama pada array sesuai format. 

### C. Mencari segment customer dengan jumlah transaksi yang paling sedikit
**Soal:** TokoShiSop berfokus tiga segment customer, antara lain: *Home Office*, *Consumer*, dan *Corporate*. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan segment customer dan jumlah transaksinya yang paling sedikit.
* Menghitung jumlah transaksi masing-masing segment customer
```bash
    if (NR>1){
        segment[$8]=segment[$8]+1
    }
```
Baris pertama pada file Laporan-TokoShiSop.tsv adalah header maka digunakan ``NR>1`` agar pembacaan dimulai dari baris ke 2. Disini digunakan array dengan ``Segment`` (**$8**) sebagai index dan counter transaksi sebagai value nya.
```bash
    for (seg in segment){
        if (transaction > segment[seg]){
            transaction = segment[seg]; segmentType = seg
        }
    }
    printf ("\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi\n", segmentType, transaction)
```
Iterasi setiap element pada array ``segment`` untuk mencari segment yang memiliki jumlah transaksi paling sedikit. Jika jumlah transaksi dari suatu segment lebih kecil dibandingkan transaksi yang disimpan saat ini maka jumlah transaksi (*segment[seg]*) dan index (*seg*) akan disimpan dalam variabel *transaction* dan *segmentType*. Setelah mendapatkan segment dengan jumlah transaksi paling sedikit akan dicetak sesuai format.

### D. Mencari region dengan total keuntungan (profit) paling sedikit
**Soal:** TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: **Central, East, South, dan West**. Manis ingin mencari wilayah bagian
(region) yang memiliki **total keuntungan (profit) paling sedikit** dan **total keuntungan wilayah** tersebut.
* Menghitung profit masing-masing region
```bash
    if(NR>1){
            regionProfit[$13]=regionProfit[$13]+$21
    }
```
Disini digunakan array ``regionProfit`` dengan ``region`` (**$13**) sebagai index. Total keuntungan masing-masing region disimpan pada array ini. Akumulasi keuntungan masing-masing region itu dihitung menggunakan ``regionProfit[$13]=regionProfit[$13]+$21``
```bash
    for (reg in regionProfit){
        if (minProfit > regionProfit[reg]){
            minProfit = regionProfit[reg]; placeReg = reg
        }
    }
    printf ("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah  %s dengan total %.2f\n", placeReg, minProfit)
```
Iterasi setiap total keuntungan masing-masing region pada array ``regionProfit`` untuk mencari region dengan total keuntungan paling sedikit. Jika total keuntungan dari suatu region lebih kecil dibandingkan nilai yang disimpan saat ini maka total keuntungan (*regionProfit[reg]*) dan index (*reg*) akan disimpan ke dalam variabel *minProfit* dan *placeReg*. Setelah mendapatkan segment dengan jumlah transaksi paling sedikit akan dicetak sesuai format.
 
### E. Membuat script hasil dari soal 2a, 2b, 2c, dan 2d yang disimpan ke 'hasil.txt' dengan format:
```
    Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

    Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
    *Nama Customer1*
    *Nama Customer2* dst

    Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

    Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```
Output soal 2a, 2b, 2c, dan 2d ditampilkan pada file **hasil.txt** dengan melakukan redirection untuk mengirim output ke file tersebut.
```Laporan-TokoShiSop.tsv >> hasil.txt```