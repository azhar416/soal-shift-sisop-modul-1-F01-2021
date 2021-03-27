#1/bin/bash

filename=$(date +"%m%d%Y")
zip -r -P"$filename" Koleksi.zip ./Kucing_* ./Kelinci_*
