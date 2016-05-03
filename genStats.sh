#!/bin/bash

total=1
for dir in Apps/*
do
   num=1
   for apps in "${dir}"/*apk
   do
      name=`echo "$apps" | awk -F "/" '{print $2}'`
      #echo $dir
      #echo $apps
      #echo $name
      #echo $num
      #echo "${name}decomp"${num}
      /home/drgardner/jadx/build/jadx/bin/./jadx -s -j 1 -d /home/drgardner/School/FDroid/"${dir}"/"${name}"decomp${num} /home/drgardner/School/FDroid/"${apps}"
      grep -w "uses-permission" /home/drgardner/School/FDroid/"${dir}"/"${name}"decomp${num}/AndroidManifest.xml | awk -F "\"" '{print $2}' | awk -F "." '{ print $NF}' >> /home/drgardner/School/FDroid/permissions.out
      num=$((num + 1))
      total=$((total+1))
   done
   #echo
done
echo $total

for permissions in `cat /home/drgardner/School/FDroid/FDroid/spiders/permissions.out`
do
   count=`grep -w "${permissions}" /home/drgardner/School/FDroid/permissions.out | wc -l`
   echo "${permissions}, ${count}" >> permissions.csv 
done
