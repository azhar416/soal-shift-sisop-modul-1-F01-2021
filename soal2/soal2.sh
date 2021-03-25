#!/bin/bash

export LC_ALL=C

# 2a
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
    }' /Users/inez_amanda/sisop/p1/soal-shift-sisop-modul-1-F01-2021/soal2/Laporan-TokoShiSop.tsv >> result.txt

# 2b
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
    }' /Users/inez_amanda/sisop/p1/soal-shift-sisop-modul-1-F01-2021/soal2/Laporan-TokoShiSop.tsv >> result.txt

# 2c
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
    }' /Users/inez_amanda/sisop/p1/soal-shift-sisop-modul-1-F01-2021/soal2/Laporan-TokoShiSop.tsv >> result.txt

# 2d
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
    }' /Users/inez_amanda/sisop/p1/soal-shift-sisop-modul-1-F01-2021/soal2/Laporan-TokoShiSop.tsv >> result.txt