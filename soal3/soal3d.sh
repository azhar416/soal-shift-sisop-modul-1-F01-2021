#1/bin/bash

filename=$(date +"%m%d%Y")
zip -r -P"$filename" Koleksi.zip ./Kucing_* ./Kelinci_*
rm -r Kucing_* 
rm -r Kelinci_*
