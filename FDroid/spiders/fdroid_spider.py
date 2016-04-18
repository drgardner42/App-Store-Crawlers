import scrapy

from FDroid.items import FdroidItem

class FdroidSpider(scrapy.Spider):
   name = "fdroid"
   allowed_domains = ["f-droid.org"]
   start_urls = ["https://f-droid.org/repository/browse/"]

   def parse(self, response):
      for sel in response.xpath('//div[@class="post-entry"]/a'):
         link = sel.xpath('@href').extract()
         print link
         yield scrapy.Request(link[0], callback=self.download_app)
      nextPage = response.xpath('//a[contains(text(), "next")]/@href').extract()
      if nextPage != []:
         yield scrapy.Request(nextPage[0], callback=self.parse)
      
   def download_app(self, response):
      item = FdroidItem() 
      item['link'] = response.xpath('//a[contains(text(), "download")]/@href').extract_first()
      item['title'] = response.xpath('//span[@style="font-size:20px"]/text()').extract()
      yield item
