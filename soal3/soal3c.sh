#1/bin/bash
 
n_kucing=$(ls | grep -e "Kucing.*" | wc -l)
n_kelinci=$(ls | grep -e "Kelinci.*" | wc -l)
 
#kondisi kucing
if [[ $n_kucing -eq $n_kelinci ]] ;
 then 
 i=1
 while [ $i -lt 24 ]
 do
    wget -O "Kitten_$i.jpg" -a Foto.log https://loremflickr.com/320/240/kitten
    i=$[$i+1]
 done
 
 files="$( find -type f )"
 for file1 in $files; do
    for file2 in $files; do
        # echo "checking $file1 and $file2"
        if [[ "$file1" != "$file2" && -e "$file1" && -e "$file2" ]]; then
            if diff "$file1" "$file2" > /dev/null; then
                echo "$file1 and $file2 are duplicates"
                rm -v "$file2"
            fi
        fi
    done
 done
 
 j=1
 for file in *.jpg; do
    echo $file
    if [[ $j -lt 10 ]]; then
      mv "$file" "Koleksi_0$j.jpg"
    else 
      mv "$file" "Koleksi_$j.jpg"
    fi
    j=$[$j+1]
 done
 
 filename=$(date +"%m-%d-%Y")
 mkdir "Kucing_$filename"
 mv ./Koleksi_* ./Foto.log "./Kucing_$filename/"
 echo "Berhasil"
 kucing=$[$kucing+1]
 
#kondisi  kelinci 
 else
 i=1
 while [ $i -lt 24 ]
 do
    wget -O "Rabbit_$i.jpg" -a Foto.log https://loremflickr.com/320/240/bunny
    i=$[$i+1]
 done
 
 files="$( find -type f )"
 for file1 in $files; do
    for file2 in $files; do
        # echo "checking $file1 and $file2"
        if [[ "$file1" != "$file2" && -e "$file1" && -e "$file2" ]]; then
            if diff "$file1" "$file2" > /dev/null; then
                echo "$file1 and $file2 are duplicates"
                rm -v "$file2"
            fi
        fi
    done
 done
 
 j=1
 for file in *.jpg; do
    echo $file
    if [[ $j -lt 10 ]]; then
      mv "$file" "Koleksi_0$j.jpg"
    else 
      mv "$file" "Koleksi_$j.jpg"
    fi
    j=$[$j+1]
 done
 
 filename=$(date +"%m-%d-%Y")
 mkdir "Kelinci_$filename"
 mv ./Koleksi_* ./Foto.log "./Kelinci_$filename/"
 echo "Berhasil"
 kelinci=$[$kelinci+1]
fi
 
