import scrapy

from FDroid.items import PermissionItem

class PermissionSpider(scrapy.Spider):
   name = "permission"
   allowed_domains = ["http://developer.android.com"]
   start_urls = ["http://developer.android.com/reference/android/Manifest.permission.html"]

   def parse(self, response):
      for sel in response.xpath('//table[@class="jd-sumtable"]/tr/td[2]/a/text()'):
         print sel
         item = PermissionItem()
         item['permission'] = sel.extract() 
         yield item
