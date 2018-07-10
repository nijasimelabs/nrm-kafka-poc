-- operational-scpc stream
DROP STREAM operationalscpc;

CREATE STREAM operationalscpc 
  (datetime BIGINT, 
   link VARCHAR, 
   modecod VARCHAR, 
   efficiency VARCHAR, 
   symbolrate VARCHAR, 
   availableiprate VARCHAR) 
  WITH (KAFKA_TOPIC='operationalscpc', 
        VALUE_FORMAT='DELIMITED', 
		TIMESTAMP='datetime', 
		KEY='link');

-- traffic-classification stream
DROP STREAM trafficclassification;
CREATE STREAM trafficclassification 
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
		
		
-- traffic-shaping stream
DROP STREAM trafficshaping;
CREATE STREAM trafficshaping 
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

-- wanoperationaldb stream
DROP STREAM wanoperationaldb;
CREATE STREAM wanoperationaldb 
  (seq INT, 
   flag VARCHAR, 
   datetime BIGINT, 
   wanlinks VARCHAR, 
   dscpValues VARCHAR, 
   potentialmatrix VARCHAR) 
  WITH (KAFKA_TOPIC='wanoperationaldb', 
        VALUE_FORMAT='DELIMITED', 
		TIMESTAMP='datetime');
		
		
