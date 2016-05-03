mkdir Apps
num=1
while read line
do
   url=`echo "$line" | grep -o "https[^\"]*"`
   name=`echo "$line" | awk -F ":" '{print $4}' | cut -c4- | rev | cut -c5- | rev`
   mkdir "Apps/${name}" || mkdir "Apps/${num}"
   cd Apps/"${name}" || cd Apps/"${num}"
   wget --tries=45 "$url"
   cd ../..
   sleep $[ ( $RANDOM % 10 ) + 1 ]s
   num=$((num + 1))
done < urls.json
