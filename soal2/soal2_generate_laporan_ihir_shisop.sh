#!/bin/bash

export LC_ALL=C

# 2a
# Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage, yaitu:

# Profit Percentage = (Profit Cost Price) 100

# Cost Price didapatkan dari pengurangan Sales dengan Profit. (Quantity diabaikan).

awk -v maximumProfit=0 'BEGIN {FS="\t"} { 
    profitPercentage=($21/($18-$21))*100 
    {
        if (profitPercentage>=maximumProfit){
            transactionId=$1
            maximumProfit=profitPercentage
        }
    }
}
END{
    printf ("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%\n", transactionId, maximumProfit)
    }' Laporan-TokoShiSop.tsv >> hasil.txt


# 2b
# Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar nama customer pada transaksi tahun 2017 di Albuquerque.

awk 'BEGIN {FS="\t"} { 
        if ($10=="Albuquerque" && $2~"2017"){
            customer[$7]=customer[$7]+1
        }
    }
    END{
        printf ("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n")
        for(name in customer) printf ("%s\n", name)
    }' Laporan-TokoShiSop.tsv >> hasil.txt


# 2c
# TokoShiSop berfokus tiga segment customer, antara lain: Home Office, Customer, dan Corporate. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan segment customer dan jumlah transaksinya yang paling sedikit.

awk 'BEGIN {FS="\t"} {
        if(NR>1){
            segment[$8]=segment[$8]+1
        }
    }
    END{
        transaction=99999
        for (seg in segment){
            if (transaction > segment[seg]){
                transaction = segment[seg]
                segmentType = seg
            }
        }
        printf ("\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi\n", segmentType, transaction)
    }' Laporan-TokoShiSop.tsv >> hasil.txt


# 2d
# TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: Central, East, South, dan West. Manis ingin mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

awk 'BEGIN {FS="\t"} {
        if(NR>1){
            region[$13]+=$21
        }
    }
    END{
        minProfit=99999
        for (reg in region){
            if (minProfit > region[reg]){
                minProfit = region[reg]
                placeReg = reg
            }
        }
        printf ("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah  %s dengan total %.2f\n", placeReg, minProfit)
    }' Laporan-TokoShiSop.tsv >> hasil.txt