# Requirements

- java 7 or 8
- kafka
- redis


# Running

- start zookeeper, kafka and redis
- install requirements.txt
- start django app
- use command-line producer to feed 'netbot-topic' topic (hardcoded in Consumers.py)
- visit /chat/<room_name> in browser,
  text area should get updated with messages from 'netbot-topic'

# Where are we
- We are bringing channel group profile api to kafka-ksql stack
- test data for wanoperationaldb, operationalscpc, trafficshaping and trafficclassification is generated
using
 ksql-datagen schema=<schema.avro> format=delimited topic=<topicname> key=<keyfield>
- avro schema files are available in etc/ dir (not tested yet)


# TODO
- write ksql queries for generating channel group profile
- query and display data in django
