# -*- coding: utf-8 -*-
import scrapy
from scrapy.selector import Selector

from ieltscrawl.items import IeltscrawlItem
from ieltscrawl.pipelines import IeltscrawlPipeline

#from ieltscrawl.pipelines import MySQLPipeline
#import urlparse
import MySQLdb


class IeltscrawlSpider(scrapy.Spider):
    name = "iecrawl"
    allowed_domains = ["ielts.britishcouncil.org"]

    start_urls = ["http://ielts.britishcouncil.org/nepal"]

    
    def parse(self, response):
    	item = IeltscrawlItem()
        pipe = IeltscrawlPipeline()
    	item['title'] = Selector(response).xpath('//*[@id="aspnetForm"]/div[2]/div[3]/div[1]/div[1]/img/@alt').extract()
    	item['date'] = Selector(response).xpath('//*[@id="ctl00_ContentPlaceHolder1_ddlDateMonthYear"]/option/@value').extract()
    	item['city'] = Selector(response).xpath('//*[@id="ctl00_ContentPlaceHolder1_ddlTownCityVenue"]/option[5]/text()').extract()
        item['module'] = Selector(response).xpath('//*[@id="ctl00_ContentPlaceHolder1_ddlModule"]/option/text()').extract()

        item['start_urls'] = response.request.url

        yield item

        print("\n\n\n NNOw Lests move to reading the db \n\n\n")

        Query = "SELECT check_date();"

        result = pipe.read_db(Query)

