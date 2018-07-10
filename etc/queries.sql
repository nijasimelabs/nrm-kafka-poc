-- traffic-classification table
DROP TABLE trclass;

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
DROP TABLE trshaping;
CREATE TABLE trshaping 
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