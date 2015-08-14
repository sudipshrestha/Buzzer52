# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html

import MySQLdb
from scrapy import log
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.MIMEBase import MIMEBase
from email.Utils import COMMASPACE, formatdate
from email import Encoders
from  smtplib import SMTPException

#import ieltscrawl.spiders.ieltscrawl_spider
from spiders.ieltscrawl_spider import *
from ieltscrawl.items import IeltscrawlItem
   
class IeltscrawlPipeline(object):
    def __init__(self):
    	self.conn = MySQLdb.connect(db = 'ieltsCrawl',
    								user = 'root',
    								passwd = 'root',
    								host = 'localhost',
    								charset = 'utf8',
    								use_unicode = True)
    	self.cursor = self.conn.cursor()

    def process_item(self, item, spider):
    	print("\n\n\nMY NAME IS SUDIP....\n\n\n")
        try:
            sql = """INSERT INTO page_details (`page_link`,`title`,  `date`, `city`, `module`)  
                    VALUES ('%s', '%s', '%s', '%s', '%s')""" %(item['start_urls'].replace("'","`"),
                                                ', '.join(item['title']),
                                                ', '.join(item['date']),
                                                ', '.join(item['city']),
                                                ', '.join(item['module']),
                                                
                        )
            result = self.cursor.execute(sql)  
            print("\n\n\nThe result is : " + str(result))          
            self.conn.commit()
            if result > 0:
                #self.stats.inc_value('database/items_added')
                print("Sucessfully INserted....")
        except MySQLdb.Error, e:
            print '!!!!!!!!!!!!!!!!!!DB Write failure!!!!!!!!!!!!'
            print "Error %d: %s" % (e.args[0], e.args[1])
            log.msg("Error %d: %s" % (e.args[0], e.args[1]), level=log.CRITICAL)

        return item

    def send_email(self, weburl):
        item = IeltscrawlItem()
        url = weburl
        gmail_user = "shresthasudip52@gmail.com"    
        gmail_pwd = "Gmail4624"
        FROM = 'shresthasudip52@gmail.com'
        TO = ['buzzer.52@gmail.com', 'rkapali@lftechnology.com', 'sudipshrestha@lftechnology.com', 'aakas.mee@gmail.com', 'naved_14@hotmail.com'] #must be a list
        SUBJECT = "Guys! Hurry Up For New Ielts Date"
        TEXT = """
                        Hello Everyone!!

                                    The new ielts date are here!! Please find the link below....

                                    IeltsLink: %s

                """%(url)
        # Prepare actual message
        message = """\From: %s\nTo: %s\nSubject: %s\n\n%s
        """ % (FROM, ", ".join(TO), SUBJECT, TEXT)
        try:
            #server = smtplib.SMTP(SERVER) 
            server = smtplib.SMTP("smtp.gmail.com", 587) #or port 465 doesn't seem to work!
            server.ehlo()
            server.starttls()
            server.login(gmail_user, gmail_pwd)
            server.sendmail(FROM, TO, message)
            #server.quit()
            server.close()
            print 'successfully sent the mail'
        except:
            print "failed to send mail"

    def read_db(self, sqlQuery, weburl):
        #ob = IeltscrawlPipeline()
        try:
            self.cursor.execute(sqlQuery)
            result = self.cursor.fetchall()
            print ("\n\n\n The result  is : " + str(result[0][0]))
            self.conn.commit()
            if(str(result[0][0]) == 'No Sucess'):
                print("\n\n\n This  is sucess wait for the email...\n\n\n")     
                self.send_email(weburl)
                if result == 0:
                    print("\n\n\n SUcessfully sent email....\n\n\n")
                return result
            elif(str(result[0][0]) == 'Sucess'):   
                print("\n\n\n No Need to send the email cuz the date is same.....\n\n\n")
            else:
                print("\n\n\n Check the  log file for debugging which will be implementedd soon\n\n\n ")    
            #sucessOutput = 
        except MySQLdb.Error, e:
            print '!!!!!!!!!!!!!!!!!!DB Write failure!!!!!!!!!!!!'
            print "Error %d: %s" % (e.args[0], e.args[1])
            log.msg("Error %d: %s" % (e.args[0], e.args[1]), level=log.CRITICAL)


    