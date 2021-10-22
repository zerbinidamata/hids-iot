import os
import json
from kafka import KafkaConsumer

group_id = os.environ["RULES_GROUP_ID"]
kafka_broker = "kafka:9092"
topic_name = f"rules_group_{group_id}"


print(f"Starting consumer for topic {topic_name}")
consumer = KafkaConsumer(topic_name, bootstrap_servers=kafka_broker)
for msg in consumer:
    print(f"Received message: {msg}")
    rules = json.loads(msg.value)
    for r in rules:
        with open("tmp.json", "r+") as f:
            json.dump(r, f)
            os.system(f"python3 app.py --insert tmp.json ")
