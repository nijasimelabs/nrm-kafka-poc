from asgiref.sync import async_to_sync
from channels.generic.websocket import WebsocketConsumer
from confluent_kafka import Consumer, KafkaError
import json


kafka_conf = {
    'bootstrap.servers': 'localhost:9092',
    'group.id': 'netbot',
    'default.topic.config': {'auto.offset.reset': 'beginning'}
}


class ChatConsumer(WebsocketConsumer):
    def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = 'chat_%s' % self.room_name

        self.kafkaConsumer = Consumer(kafka_conf)
        self.kafkaConsumer.subscribe(['netbot-topic'])
        self.kafkaStreaming = False

        # Join room group
        async_to_sync(self.channel_layer.group_add)(
            self.room_group_name,
            self.channel_name
        )

        self.accept()

    def disconnect(self, close_code):
        self.kafkaStreaming = False
        # Leave room group
        async_to_sync(self.channel_layer.group_discard)(
            self.room_group_name,
            self.channel_name
        )

    # Receive message from WebSocket
    def receive(self, text_data):
        print('received message from socket')
        text_data_json = json.loads(text_data)
        message = text_data_json['message']
        async_to_sync(self.channel_layer.group_send)(
            self.room_group_name,
            {
                'type': 'chat_message',
                'message': message,
            }
        )

    # Receive message from room group
    def chat_message(self, event):
        print('received message from groupd')

        # already streaming from kafka
        if self.kafkaStreaming:
            print('already streaming from kafka')
            return

        self.kafkaStreaming = True

        while self.kafkaStreaming:
            msg = self.kafkaConsumer.poll()

            if msg.error():
                if msg.error().code() == KafkaError._PARTITION_EOF:
                    print('No more messages')
                    continue
                else:
                    print(msg.error())
                    break

            print(msg.value().decode('utf-8'))
            print('sending message to client')
            # Send message to WebSocket
            self.send(text_data=json.dumps({
                'message': msg.value().decode('utf-8'),
            }))

        print('closing kafka stream')
        self.kafkaConsumer.close()

        # self.send(text_data=json.dumps({
        #     'message': event['message'],
        # }))
