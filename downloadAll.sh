#/bin/bash

clear

echo "Beginning scraper"
scrapy crawl fdroid -o urls.json

clear
echo "Scraping Finished"

appCount=`wc -l urls.json`
echo "A total of ${appCount: (-5)} APKs will be downloaded"

bash getStuff.sh
