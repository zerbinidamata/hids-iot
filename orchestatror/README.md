# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## System dependencies
```
docker-compose
docker
```
# Configuration
`docker-compose build`
`docker-compose up`

* Database initialization

`docker-compose run orchestrator rake db:create db:seed db:migrate `

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# Kafka
## Kafka commands

### Create Topic

```
kafka-topics.sh --create \
  --zookeeper zookeeper:2181 \
  --replication-factor 1 --partitions 13 \
  --topic devices_rules
```
### Produce messages

```
  kafka-console-producer.sh \
    --broker-list kafka:9092 \
    --topic devices_rules
```