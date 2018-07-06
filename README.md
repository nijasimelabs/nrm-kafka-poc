# Requirements

- kafka
- redis


# Running

- start zookeeper, kafka and redis
- install requirements.txt
- start django app
- use command-line producer to feed 'netbot-topic' topic (hardcoded in Consumers.py)
- visit /chat/<room_name> in browser,
  text area should get updated with messages from 'netbot-topic'



# TODO

- use ksql, may need to use confluent platform
- generate and feed two streams to kafka
- use ksql to filter/aggregate/window/join streams and write to ksql table
- query ksql tables and display results in django app
