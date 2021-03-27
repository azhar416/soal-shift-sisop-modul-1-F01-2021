#1/bin/bash



#kondisi kucing
if [[  ]] ;
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
      mv "$file" "Kucing_0$j.jpg"
    else 
      mv "$file" "Kucing_$j.jpg"
    fi
    j=$[$j+1]
 done
 
 filename=$(date +"%m-%d-%Y")
 mkdir "Kucing_$filename"
 mv ./Kucing_* ./Foto.log "./Kucing_$filename/"
 echo "Berhasil"

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
      mv "$file" "Kelinci_0$j.jpg"
    else 
      mv "$file" "Kelinci_$j.jpg"
    fi
    j=$[$j+1]
 done
 
 filename=$(date +"%m-%d-%Y")
 mkdir "Kelinci_$filename"
 mv ./Kelinci_* ./Foto.log "./Kelinci_$filename/"
 echo "Berhasil"
fi
