CREATE DATABASE webCrawl_ideal;

USE webCrawl_ideal;

DROP TABLE IF EXISTS webCrawl_ideal.page;
CREATE TABLE webCrawl_ideal.page
(
	page_id 		    BIGINT(20) unsigned auto_increment COMMENT 'unique ID for each of the product link',
    page_link 			varchar(255) NOT NULL  COMMENT 'ful link of each of the products page',
    page_shortlink 		varchar(255) DEFAULT NULL  COMMENT 'short link of each of the product page',
    PRIMARY KEY (page_id),
    key `page_link`(page_link)
);

DROP TABLE IF EXISTS webCrawl_ideal.page_tags;
CREATE TABLE webCrawl_ideal.page_tags
(
	tag_id 				BIGINT(20) unsigned auto_increment,
    page_link 			varchar(255) NOT NULL,
    tags 				text DEFAULT NULL COMMENT 'comma seperated tags for  each  of  the page',
    key `page_link_id`(`page_link`),
    CONSTRAINT fk_PerOrders FOREIGN KEY (page_link) REFERENCES page(page_link),
    PRIMARY KEY (tag_id)
);


DROP TABLE IF EXISTS webCrawl_ideal.page_details;
CREATE TABLE webCrawl_ideal.page_details
(
	page_id 			BIGINT(20) unsigned,
    page_link 			VARCHAR(255) NOT NULL,
    page_shortlink 		VARCHAR(255) NOT NULL,
    title   			VARCHAR(255) default null,
    image				text DEFAULT NULL,
    brand				varchar(255) DEFAULT NULL,
    ratings				varchar(255) DEFAULT NULL,
    features 			TEXT DEFAULT NULL,
    price				DECIMAL(20,0) DEFAULT NULL,
    is_loaded           int(11) DEFAULT '0'
    PRIMARY KEY(page_id),
    FOREIGN KEY (page_id) REFERENCES page(page_id)
    
);


INSERT INTO webCrawl_ideal.page(page_link, page_shortlink) 
VALUES ('http://www.amazon.com/Cards-Against-Humanity-LLC-CAHUS/dp/B004S8F7QM/ref=zg_bs_toys-and-games_home_1/187-8833680-5864822?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=center-1&pf_rd_r=14QQVRJAT0VVDZV92RTH&pf_rd_t=2101&pf_rd_p=2140216822&pf_rd_i=home','http://www.amazon.com');

INSERT INTO webCrawl_ideal.page(page_link, page_shortlink) 
VALUES ('http://www.amazon.com/Crayola-64-Ct-Crayons-52-0064/dp/B00004YO15/ref=zg_bs_toys-and-games_home_2/187-8833680-5864822?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=center-1&pf_rd_r=14QQVRJAT0VVDZV92RTH&pf_rd_t=2101&pf_rd_p=2140216822&pf_rd_i=home','http://www.amazon.com');


SELECT * FROM webCrawl_ideal.page;


INSERT INTO webCrawl_ideal.page_tags(page_link, tags)
VALUES('http://www.amazon.com/Cards-Against-Humanity-LLC-CAHUS/dp/B004S8F7QM/ref=zg_bs_toys-and-games_home_1/187-8833680-5864822?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=center-1&pf_rd_r=14QQVRJAT0VVDZV92RTH&pf_rd_t=2101&pf_rd_p=2140216822&pf_rd_i=home','cards, playing cards for humans, card deck');
INSERT INTO webCrawl_ideal.page_tags(page_link, tags)
VALUES('http://www.amazon.com/Crayola-64-Ct-Crayons-52-0064/dp/B00004YO15/ref=zg_bs_toys-and-games_home_2/187-8833680-5864822?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=center-1&pf_rd_r=14QQVRJAT0VVDZV92RTH&pf_rd_t=2101&pf_rd_p=2140216822&pf_rd_i=home','pencil colors, colors,crayola, crayons');


SELECT * FROM webCrawl_ideal.page_tags;


INSERT INTO webCrawl_ideal.page_details(page_id, page_link, title, image, brand, ratings, features, price )
VALUES (1, 'http://www.amazon.com/Cards-Against-Humanity-LLC-CAHUS/dp/B004S8F7QM/ref=zg_bs_toys-and-games_home_1/187-8833680-5864822?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=center-1&pf_rd_r=14QQVRJAT0VVDZV92RTH&pf_rd_t=2101&pf_rd_p=2140216822&pf_rd_i=home',
'Cards Against Humanity', 'http://ecx.images-amazon.com/images/I/51RD-Lha01L._SX522_.jpg', ' Cards Against Humanity LLC.','4.9 out of 5 stars', '550 cards (460 White cards and 90 Black cards)
    Over 13 duodecillion possible rounds (10^40) with 6 players
    Professionally printed on premium playing cards
    Includes game rules and alternate rules, shrink-wrapped in a custom box
    0% of the proceeds will be donated to the Make-A-Wish Foundation', '$25.00'  );                                            
                                                      


DROP TABLE IF EXISTS webCrawl_ideal.pinterest_image;
CREATE TABLE webCrawl_ideal.pinterest_image
(
    page_id             BIGINT(20) unsigned,
    page_link           VARCHAR(255) NOT NULL,
    image               text DEFAULT NULL COMMENT 'Link to image are given here',
    PRIMARY KEY(page_id),
    FOREIGN KEY (page_id) REFERENCES page(page_id)
    
);





DROP TRIGGER IF EXISTS aft_ins_page_details_upd_shrt_link;
delimiter //
CREATE TRIGGER aft_ins_page_details_upd_shrt_link BEFORE INSERT ON page_details
FOR EACH ROW
begin
		
        SET New.page_shortlink = substring_index(new.page_link, '/', 3);

END;
//
                                                 
