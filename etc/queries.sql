-- traffic-classification table

CREATE TABLE trclass 
  (datetime BIGINT, 
   link VARCHAR, 
   classname VARCHAR, 
   enable VARCHAR, 
   expression VARCHAR, 
   nodename VARCHAR, 
   matchingorder INT) 
  WITH (KAFKA_TOPIC='trafficclassification', 
        VALUE_FORMAT='DELIMITED', 
		TIMESTAMP='datetime', 
		KEY='link');
		
		
-- traffic-shaping table
CREATE STREAM trshaping 
  (datetime BIGINT, 
   link VARCHAR, 
   nodename VARCHAR, 
   enable VARCHAR, 
   parentnode INT, 
   cir VARCHAR, 
   mir VARCHAR, 
   channel VARCHAR, 
   ratepriority INT, 
   maxqueuetime INT, 
   shapingunit INT) 
  WITH (KAFKA_TOPIC='trafficshaping', 
        VALUE_FORMAT='DELIMITED', 
		KEY='link', 
		TIMESTAMP='datetime');
		
		
-- result table

CREATE STREAM trconfigstream 
WITH (VALUE_FORMAT='DELIMITED', 
	  TIMESTAMP='datetime') 
AS SELECT 
	trshaping.datetime as datetime, 
	trshaping.link as link, 
	classname, 
	trclass.enable as enable, 
	expression, 
	cir, 
	mir 
FROM trshaping LEFT JOIN trclass 
ON trshaping.link = trclass.link 
WHERE trshaping.nodename = trclass.nodename;


CREATE TABLE trconfig
WITH (VALUE_FORMAT='DELIMITED', 
	  TIMESTAMP='datetime') 
AS SELECT 
	datetime, 
	link, 
	classname, 
	enable, 
	expression, 
	cir, 
	mir 
FROM trconfigstream;