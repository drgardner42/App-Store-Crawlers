FDroid Crawler is a collection of bash scripts that utilizes the Scrapy framework
and wget to download the entire FDroid app store to your computer. GenStats will
decompile manifests by using the jadx decompiler and output into a CSV file.

Dependencies: Scrapy, Jadx, Linux

To Run: Install Scrapy, Jadx, run on linux, and edit genStats.sh to point to
        your jadx install executable.
        
        "bash downloadAll.sh"
        "bash genStats.sh"

This will take ~7 hours to run in total.

Made for an internet algorithms class to learn web crawler basics.
Intended to be an intro to web crawlers, not actual use.

Developed on Ubuntu
