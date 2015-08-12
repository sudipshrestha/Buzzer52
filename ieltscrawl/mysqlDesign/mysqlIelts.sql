CREATE DATABASE ieltsCrawl;
use ieltsCrawl;
    
CREATE TABLE page_details(
page_details_id int(11) unsigned auto_increment,
page_link varchar(255) default NULL,
title varchar(255) default NULL,
date varchar(255) DEFAULT NULL,
city varchar(255) DEFAULT NULL,
module varchar(255) DEFAULT NULL,
primary key(page_details_id)
);


DROP PROCEDURE IF EXISTS ieltsCrawl.check_date;

DROP FUNCTION IF EXISTS  check_date;
DELIMITER $$
CREATE FUNCTION check_date () 
RETURNS varchar(255)
DETERMINISTIC
BEGIN 
  DECLARE new_id integer;
  DECLARE old_id integer;
  DECLARE new_date varchar(255);
  DECLARE old_date varchar(255);
  DECLARE result varchar(255);
  DECLARE res integer;

  SELECT (AUTO_INCREMENT -1) into new_id
						FROM information_schema.tables
						WHERE table_name = 'page_details'
						AND table_schema = 'ieltsCrawl' ;
  SELECT (new_id -1) into  old_id;
    
  SELECT date into new_date from ieltsCrawl.page_details where page_details_id = new_id;
  SELECT date into old_date from ieltsCrawl.page_details where page_details_id = old_id;
  SELECT strcmp(new_date,old_date) into result;
  SELecT ifNull(result, 1) into res;
  if res = 1 then 
		Return 'No Sucess';
  else 
		Return 'Sucess';
  end if;      
        
END $$
DELIMITER ;


-- DELETE FROM ieltsCrawl.page_details where page_details_id > 3;



-- SELECT check_date();
