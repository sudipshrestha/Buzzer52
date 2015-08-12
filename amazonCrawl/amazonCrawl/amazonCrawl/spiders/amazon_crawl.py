# -*- coding: utf-8 -*-
import scrapy
from scrapy.selector import Selector

from amazonCrawl.items import AmazoncrawlItem



class AmazoncrawlSpider(scrapy.Spider):
    name = "amaz"
    allowed_domains = ["amazon.com"]
    start_urls = (
        'http://www.amazon.com/Cards-Against-Humanity-LLC-CAHUS/dp/B004S8F7QM/ref=zg_bs_toys-and-games_home_1?pf_rd_p=2140216822&pf_rd_s=center-1&pf_rd_t=2101&pf_rd_i=home&pf_rd_m=ATVPDKIKX0DER&pf_rd_r=1EPNQ0KJ8QACXAEXVYAD',
    )

    def parse(self, response):
    	item = AmazoncrawlItem()
    	item['title'] = Selector(response).xpath('//*[@id="productTitle"]/text()').extract()
    	item['brand'] = Selector(response).xpath('//*[@id="brand"]/text()').extract()
    	item['image'] = Selector(response).xpath('//*[@img').extract
    	yield item
