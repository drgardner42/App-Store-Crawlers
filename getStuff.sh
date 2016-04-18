mkdir Apps
while read line
do
   url=`echo "$line" | grep -o "https[^\"]*"`
   name=`echo "$line" | awk -F ":" '{print $4}' | cut -c4- | rev | cut -c5- | rev`
   mkdir "/home/drgardner/School/FDroid/Apps/${name}"
   cd /home/drgardner/School/FDroid/Apps
   cd "$name"
   wget --tries=45 "$url"
   sleep $[ ( $RANDOM % 10 ) + 1 ]s
done < urls.json
