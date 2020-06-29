# Debezium Demo 


### Create mysql-config
kubectl create configmap mysql-config --from-file=mysql.cnf

### Delete Kafka Topic(s)
./kafka-topics.sh --bootstrap-server=localhost:9092 --delete --topic my_connect_statuses

### List Kafka Topics
./kafka-topics.sh --bootstrap-server=localhost:9094 --list

### Consumer Kafka Topic
./kafka-console-consumer.sh  --bootstrap-server localhost:9092 --topic dbserver1.inventory.customers

### Insert row into MySQL
INSERT INTO customers VALUES (default, "Kenneth", "Anderson", "kander@acme.com");

