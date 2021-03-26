#!/bin/bash

bash ./soal3a.sh

filename=$(date +"%m-%d-%Y")
mkdir "$filename"
mv ./Koleksi_* ./Foto.log "./$filename/"
echo "Berhasil"
