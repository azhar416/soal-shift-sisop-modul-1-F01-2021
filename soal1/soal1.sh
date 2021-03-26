#!/bin/bash
IFS=

# 1a
regex="(INFO |ERROR )(.*)((?=[\(])(.*))"
regex1="(?<=ERROR )(.*)(?=\ )"
regex2="(?<=[(])(.*)(?=[)])"
regex3="(?=[(])(.*)(?<=[)])"
input="syslog.log";
# str="Jan 31 00:16:25 ubuntu.local ticky: INFO Closed ticket [#1754] (noel)"

# 1b
error_msg=$(grep -oP "$regex1" "$input" | sort)
# echo $error_msg
echo ERROR_MESSAGE
echo $error_msg | uniq -c | sort -nr

# 1c
error=$(grep -oP "ERROR.*" "$input")
# echo $error
echo ERROR
grep -oP "$regex2" <<< "$error" | sort | uniq -c
info=$(grep -oP "INFO.*" "$input")
# echo $info
echo INFO
grep -oP "$regex2" <<< "$info" | sort | uniq -c

# 1d
printf "ERROR,COUNT\n" > "error_message.csv" 
grep -oP "$regex1" "$input" | sort | uniq -c | sort -nr | grep -oP "^ *[0-9]+ \K.*" | while read -r em; do
count=$(grep "$em" <<< "$error_msg" | wc -l)
# echo $em
# echo $count
printf "%s,%d\n" "$em" "$count" >> "error_message.csv"
done 

# 1e
printf "Username,INFO,ERROR\n" > "user_statistic.csv"
grep -oP "$regex3" <<< "$error" | sort | uniq | while read -r er; do
user=$(grep -oP "(?<=[(])(.*)(?=[)])" <<< "$er")
n_error=$(grep "$er" <<< "$error" | wc -l)
n_info=$(grep "$er" <<< "$info" | wc -l)
# echo $er
# echo $user
# echo $n_error
# echo $n_info
printf "%s,%d,%d\n" "$user" "$n_info" "$n_error" >> "user_statistic.csv"
done





