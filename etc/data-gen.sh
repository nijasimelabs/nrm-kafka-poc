#!/bin/bash
CONFLUENT_BIN="/home/ubuntu/confluent/bin/"


start() {
	echo "Clearing pervious logs...."
	rm -f log/*.log

	echo "Starting data generators...."
	${CONFLUENT_BIN}ksql-datagen schema=wan-operational-db.avro format=delimited topic=wanoperationaldb key=seq  > /dev/null 2> log/wan.log &
	echo $! > log/wan.pid
	${CONFLUENT_BIN}ksql-datagen schema=operational-scpc.avro format=delimited topic=operationalscpc key=link  > /dev/null 2> log/op.log &
	echo $! > log/op.pid
	${CONFLUENT_BIN}ksql-datagen schema=traffic-classification.avro format=delimited topic=trafficclassification key=link  > /dev/null 2> log/tr-shift.log &
	echo $! > log/tr-class.pid
	${CONFLUENT_BIN}ksql-datagen schema=traffic-shaping.avro format=delimited topic=trafficshaping key=link  > /dev/null 2> log/tr-class.log &
	echo $! > log/tr-shift.pid
}

stop() {
	echo "Killing data generators...."
	kill -9 `cat log/wan.pid`
	kill -9 `cat log/op.pid`
	kill -9 `cat log/tr-class.pid`
	kill -9 `cat log/tr-shift.pid`
}


case $1 in
    "start" )
        start ;;
    "stop" )
		stop ;;
    * )
		echo "Unknown command $1"
esac