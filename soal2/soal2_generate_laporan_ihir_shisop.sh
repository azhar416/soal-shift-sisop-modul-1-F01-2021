#!/bin/bash

export LC_ALL=C

# 2a
# Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui Row ID dan profit percentage terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage, yaitu:

# Profit Percentage = (Profit Cost Price) 100

# Cost Price didapatkan dari pengurangan Sales dengan Profit. (Quantity diabaikan).

awk 'BEGIN {FS="\t"} { 
    profitPercentage=($21/($18-$21))*100 
    {
        if (maximumProfit<=profitPercentage){
            maximumProfit=profitPercentage
            transactionId=$1
        }
    }
}
END{
    print "Transaksi terakhir dengan profit percentage terbesar yaitu ", transactionId, " dengan persentase ", maximumProfit, "%\n"
    }' /Users/inez_amanda/sisop/p1/soal-shift-sisop-modul-1-F01-2021/soal2/Laporan-TokoShiSop.tsv >> hasil.txt


# 2b
# Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar nama customer pada transaksi tahun 2017 di Albuquerque.

awk 'BEGIN {FS="\t"} { 
        if ($10=="Albuquerque" && $2~"2017"){
            customer[$7]+=1
        }
    }
    END{
        print "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
        {for(name in customer){
            print name
        }}
    }' /Users/inez_amanda/sisop/p1/soal-shift-sisop-modul-1-F01-2021/soal2/Laporan-TokoShiSop.tsv >> hasil.txt


# 2c
# TokoShiSop berfokus tiga segment customer, antara lain: Home Office, Customer, dan Corporate. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan segment customer dan jumlah transaksinya yang paling sedikit.

awk -F"\t" 'BEGIN {} {
        if(NR>1){
            segment[$8]+=1
        }
    }
    END{
        transaction=99999
        {for (seg in segment){
            if (transaction > segment[seg]){
                transaction = segment[seg]
                segmentType = seg
            }
        }
    }
        print "\nTipe segmen customer yang penjualannya paling sedikit adalah ", segmentType, " dengan ", transaction, " transaksi"
    }' /Users/inez_amanda/sisop/p1/soal-shift-sisop-modul-1-F01-2021/soal2/Laporan-TokoShiSop.tsv >> hasil.txt


# 2d
# TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: Central, East, South, dan West. Manis ingin mencari wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

awk 'BEGIN {FS="\t"} {
        if(NR>1){
            region[$13]+=$21
        }
    }
    END{
        minProfit=99999
        {for (reg in region){
            if (minProfit > region[reg]){
                minProfit = region[reg]
                placeReg = reg
            }
        }
    }
        print "\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah  ", placeReg, " dengan total keuntungan", minProfit
    }' /Users/inez_amanda/sisop/p1/soal-shift-sisop-modul-1-F01-2021/soal2/Laporan-TokoShiSop.tsv >> hasil.txt