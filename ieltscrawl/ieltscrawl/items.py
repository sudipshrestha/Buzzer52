# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class IeltscrawlItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    start_urls  = scrapy.Field()
    title = scrapy.Field()
    date = scrapy.Field()
    city = scrapy.Field()
    module = scrapy.Field()
