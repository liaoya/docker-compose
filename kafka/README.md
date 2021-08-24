# README

Combine the first two and form a deployment.
The management UI `kafka-ui` is <http://localhost:8080>

Some good references

- <https://github.com/wurstmeister/kafka-docker>
- <https://github.com/provectus/kafka-ui>
- <https://github.com/conduktor/kafka-stack-docker-compose>
- <https://www.baeldung.com/ops/kafka-docker-setup>

## Usage

```bash
# Attach to kafka service
docker-compose exec kafka bash

cd /opt/kafka

bin/kafka-topics.sh --list --zookeeper zookeeper:2181

bin/kafka-console-consumer.sh --topic test --from-beginning --bootstrap-server localhost:9082
```
