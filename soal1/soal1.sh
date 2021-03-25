#!/bin/bash
IFS=

# 1a
# regex="(INFO |ERROR )(.*)((?=[\(])(.*))"
regex1="(?<=ERROR )(.*)(?=\ )"
regex2="(?<=[(])(.*)(?=[)])"
input="syslog.log";
# str="Jan 31 00:16:25 ubuntu.local ticky: INFO Closed ticket [#1754] (noel)"

# 1b
error_msg=$(grep -oP "$regex1" "$input" | sort)
# echo $error_msg
# echo $error_msg | uniq -c | sort -nr

# 1c
error=$(grep -oP "ERROR.*" "$input")
# echo $error
# grep -oP "$regex2" <<< "$error" | sort | uniq -c
info=$(grep -oP "INFO.*" "$input")
# echo $info
# grep -oP "$regex2" <<< "$info" | sort | uniq -c

# 1d
printf "ERROR,COUNT\n" > "error_message.csv" 
grep -oP "$regex1" "$input" | sort | uniq -c | sort -nr | grep -oP "^ *[0-9]+ \K.*" | while read -r em; do
count=$(grep "$em" <<< "$error_msg" | wc -l)
# echo $em
# echo $count
printf "%s,%d\n" "$em" "$count" >> "error_message.csv"
done 

# 1e








