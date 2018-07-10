#!/bin/bash
CONFLUENT_BIN="/home/ubuntu/confluent/bin/"
${CONFLUENT_BIN}ksql-datagen schema=wan-operational-db.avro format=delimited topic=wanoperationaldb key=seq  > /dev/null 2> log/wan.log &
${CONFLUENT_BIN}ksql-datagen schema=operational-scpc.avro format=delimited topic=operationalscpc key=link  > /dev/null 2> op.log &
${CONFLUENT_BIN}ksql-datagen schema=traffic-classification.avro format=delimited topic=trafficclassification key=link  > /dev/null 2> tr-shift.log &
${CONFLUENT_BIN}ksql-datagen schema=traffic-shaping.avro format=delimited topic=trafficshaping key=link  > /dev/null 2> tr-class.log &