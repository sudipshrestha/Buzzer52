 CREATE KEYSPACE webcrawl with REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1}


CREATE TABLE if not exists page
(
	pageid uuid,
	pageurl text,
	pageurl_short text,
	keywords list<varchar>,
	primary key (pageid)
	
);

CREATE TABLE if not exists page_keywords
(
	pageid uuid,
	keywords list<varchar>,
	primary key(pageid)
);


Create TABLE if not exists page_title
(
	pageid uuid,
	pageurl text,
	pageurl_short text,
	page_title varchar,
	primary key (pageid,page_title)
);

CREATE TABLE if not exists page_images
(
	pageid uuid,
	pageurl text,
	pageurl_short text,
	page_images BLOB,
	primary key(pageid)
);


CREATE TABLE if not exists page_ratings
(
	pageid uuid,
	pageurl text,
	pageurl_short text,
	page_ratings varchar,
	rating_images BLOB,
	primary key(pageid)
);


CREATE TABLE if not exists page_brand
(
	pageid uuid,
	pageurl text,
	pageurl_short text,
	page_brand varchar,
	primary key(pageid)
);

CREATE TABLE if not exists page_features
(
	pageid uuid,
	pageurl text,
	pageurl_short text,
	page_features text,
	primary key(pageid)
);


CREATE TABLE if not exists page_item_price
(
	pageid uuid,
	pageurl text,
	pageurl_short text,
	price int,
	primary key(pageid)
);


CREATE TABLE if not exists pinterest_image
(
	pageid uuid,
	keywords list<varchar>,
	pinterest_images list<BLOB>,
	primary key(pageid)
);



DROP TRIGGER IF EXISTS aft_ins_page_details_upd_shrt_link;
delimiter //
CREATE TRIGGER aft_ins_page_details_upd_shrt_link BEFORE INSERT ON page_details
FOR EACH ROW
begin
		
        SET New.page_shortlink = substring_index(new.page_link, '/', 3);

END;
//
