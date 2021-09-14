import sys
import logging
from kafka import KafkaProducer
from kafka import KafkaConsumer
import kafka

topic = 'wbphoto_album_expo'
brokers_list = ["10.182.11.30:9092", "10.182.11.31:9092","10.182.11.32:9092","10.182.11.33:9092","10.182.11.34:9092"]

handler = logging.StreamHandler(sys.stdout)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
handler.setLevel(logging.DEBUG)

#kafka_log = logging.getLogger('kafka.consumer')
#kafka_log.setLevel(logging.DEBUG)
#kafka_log.addHandler(handler)

print(kafka.__version__)

def write_kafka():
    print("Producer mode")
    producer = KafkaProducer(bootstrap_servers=brokers_list)

    print(producer.partitions_for(topic))
    # Asynchronous by default
    future = producer.send(topic, b'test from zhujun')

    # Block for 'synchronous' sends
    try:
        record_metadata = future.get(timeout=10)
    except KafkaError as ex:
        print(ex)
        sys.exit(-1)
    print ("Success")
    print ("Topic: ", record_metadata.topic)
    print ("Partition: ", record_metadata.partition)
    print ("Offset: ", record_metadata.offset)


def read_kafka():
    print("Consumer mode")
    consumer = KafkaConsumer(topic, 
                             group_id='wbphoto_album_expo-topic-test',
                             bootstrap_servers=brokers_list,
                             auto_offset_reset='latest',
                             auto_commit_interval_ms=2000)
   
    print("begin")
    print(consumer.topics())
    for message in consumer:
        print ("%s:%d:%d: key=%s value=%s" % (message.topic, message.partition,
                                              message.offset, message.key,
                                              message.value))

if __name__ == "__main__":
    if sys.argv[1] == 'p':
        write_kafka()
    elif sys.argv[1] == 'c':
        read_kafka()
