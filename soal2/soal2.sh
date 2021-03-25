#!/bin/zsh

export LC_ALL=C
awk -F "\t" 'BEGIN {} { 
    profitPercentage=$21/($18-$21)*100} {
        if (max<=profitPercentage){
            max=profitPercentage
            RowID=$1
        }
    }
    END{
        print "Profit percentage terbesar : ", RowID, "(", max, "%)\n"
    }' /Users/inez_amanda/sisop/p1/Laporan-TokoShiSop.tsv >> result.txt

export LC_ALL=;
awk -F "\t" 'BEGIN {} { 
        if ($10 -eq "Albuquerque" && $2~"2017"){
            customer[$7]+=1
        }
    }
    END{
        print "\nCustomer di Albuquerque tahun 2017 :\n"
        {for(name in customer){
            print name
        }}
    }' /Users/inez_amanda/sisop/p1/Laporan-TokoShiSop.tsv >> result.txt

# awk -F "\t" 'BEGIN {} {
#         if(NR>1){ segment[$8]+=1 }
#     }
#     END{
#         minimal=9999{
#             for (bidang in segment){
#                 if (minimal > segment[bidang]){
#                     minimal = segment[bidang]
#                     minimal = segment
#                 }
#             }
#         }
#         print "\nTipe segmen "
#     }
#     '