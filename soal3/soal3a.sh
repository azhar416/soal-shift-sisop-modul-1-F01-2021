#!/bin/bash

declare -A arr
shopt -s globstar

for i in {1..23}
do
    wget -O Koleksi_$i https://loremflickr.com/320/240/kitten 
done

for file in **; do
  [[ -f "$file" ]] || continue
   
  read cksm _ < <(md5sum "$file")
  if ((arr[$cksm]++)); then 
    echo "rm $file"
  fi
done
