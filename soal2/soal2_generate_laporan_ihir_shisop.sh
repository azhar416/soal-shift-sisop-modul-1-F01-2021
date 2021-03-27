#!/bin/bash

export LC_ALL=C

# 2a
# Profit Percentage = (Profit / (Cost-Price)) * 100
# Hitung maximumProft dari keseluruhan data

awk -v maximumProfit=0 'BEGIN {FS="\t"} { 
    profitPercentage=($21/($18-$21))*100 
    {
        if (profitPercentage>=maximumProfit){
            transactionId=$1; maximumProfit=profitPercentage
        }
    }
}
END{
    printf ("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%\n", transactionId, maximumProfit)
}' Laporan-TokoShiSop.tsv >> hasil.txt


# 2b
# Mendapatkan daftar nama customer pada transaksi tahun 2017 di Albuquerque.

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
# Mendapatkan segment customer dan jumlah transaksinya yang paling sedikit.

awk -v transaction=9999 'BEGIN {FS="\t"} {
        if(NR>1){
            segment[$8]=segment[$8]+1
        }
    }
END{
    for (seg in segment){
        if (transaction > segment[seg]){
            transaction = segment[seg]; segmentType = seg
        }
    }
    printf ("\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d transaksi\n", segmentType, transaction)
}' Laporan-TokoShiSop.tsv >> hasil.txt


# 2d
# Mendapatkan wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit dan total keuntungan wilayah tersebut.

awk -v minProfit=99999 'BEGIN {FS="\t"} {
        if(NR>1){
            region[$13]=region[$13]+$21
        }
    }
END{
    for (reg in region){
        if (minProfit > region[reg]){
            minProfit = region[reg]; placeReg = reg
        }
    }
    printf ("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah  %s dengan total %.2f\n", placeReg, minProfit)
}' Laporan-TokoShiSop.tsv >> hasil.txt