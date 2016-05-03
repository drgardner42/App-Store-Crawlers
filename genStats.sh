#!/bin/bash

total=1
#if not first time running, need to delete original .out and .csv to not skew statistics
rm permissions.out
rm permissions.csv

#generate the file of all app permissions used by every application
for dir in Apps/*
do
   num=1
   #This for loop takes care of the special case of multiple apps having the same title(thus same directory)
   for apps in "${dir}"/*apk
   do
      name=`echo "$apps" | awk -F "/" '{print $2}'`

      #This needs to be changed to where your jadx build is installed
      /home/drgardner/jadx/build/jadx/bin/./jadx -s -j 1 -d "${dir}"/"${name}"decomp${num} "${apps}"
      grep -w "uses-permission" "${dir}"/"${name}"decomp${num}/AndroidManifest.xml | awk -F "\"" '{print $2}' | awk -F "." '{ print $NF}' >> permissions.out
      num=$((num + 1))
      total=$((total+1))
   done
done
echo $total

scrapy crawl permission -o permissions.json
cat permissions.json | awk -F "\"" '{print $4}' > permissionsList.txt

for permissions in `cat permissionsList.txt`
do
   count=`grep -w "${permissions}" permissions.out | wc -l`
   echo "${permissions}, ${count}, ${total}" >> permissions.csv 
done
