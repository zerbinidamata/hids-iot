import os
from kafka import KafkaProducer
from json import dumps
import argparse


group_id = os.environ["RULES_GROUP_ID"]
kafka_broker = "localhost:9093"
topic_name = "devices_rules"

producer = KafkaProducer(
    value_serializer=lambda x: dumps(x).encode("utf-8"),
    bootstrap_servers=kafka_broker,
)


def generate_report(data):
    print(data)
    producer.send(topic_name, value=data)
