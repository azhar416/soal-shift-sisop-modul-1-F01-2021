#!/bin/bash

declare -A arr
shopt -s globstar

#loop
for i in {1..10}
do
    wget -O Koleksi_$i -a Foto.log https://loremflickr.com/320/240/kitten
    echo "file Koleksi_$i sudah terdownload"
done

for file in **; do
  [[ -f "$file" ]] || continue
   
  read cksm _ < <(md5sum "$file")
  if ((arr[$cksm]++)); then 
    rm $file
  fi
done
