# Debezium Demo
### Create namespaces
kubectl create ns kafka
kubectl create ns my-kafka-project

## Deploy MySQL Database
### Create configmap
kubectl create configmap mysql-config --from-file=mysql.cnf -n my-kafka-project

### Deploy MySQL database
kubectl apply -f mysql-deployment.yaml -n my-kafka-project

### Deploy MySQL database
kubectl apply -f mysql-deployment.yaml -n my-kafka-project


## Deploy Kafka using Strimzi Operator
### Deploy Strimzi CRDs and RBAC resources in "kafka" namespace
kubectl apply -f ../strimzi/install/cluster-operator -n kafka

### Give permission to Cluster Operator to watch "my-kafka-project" namespace
kubectl apply -f ../strimzi/install/cluster-operator/020-RoleBinding-strimzi-cluster-operator.yaml -n my-kafka-project
kubectl apply -f ../strimzi/install/cluster-operator/032-RoleBinding-strimzi-cluster-operator-topic-operator-delegation.yaml -n my-kafka-project
kubectl apply -f ../strimzi/install/cluster-operator/031-RoleBinding-strimzi-cluster-operator-entity-operator-delegation.yaml -n my-kafka-project

### Deploy Kafka and Zookeeper
kubectl apply -f kafka.yaml -n my-kafka-project


## Debezium Connect
### Deploy Debezium Connect
kubectl apply -f debezium-connect-deployment.yaml -n my-kafka-project



## Demo Steps
### List Kafka Topics
./bin/kafka-topics.sh --bootstrap-server=localhost:9094 --list

### Deploy Debezium Connect
kubectl apply -f debezium-connect-deployment.yaml -n my-kafka-project

### List Kafka Topics after Deploying Debezium Connect
./bin/kafka-topics.sh --bootstrap-server=localhost:9094 --list

### Register Debezium Connector via API
run init.sh

### Show Registered Debezium Connectors via API
curl -Lvvv debezium-connect.my-kafka-project.svc/connectors

### Create database and tables
mysql -u root -pdebezium
run inventory.sql

### Listen on Consumer Kafka Topic
./bin/kafka-console-consumer.sh  --bootstrap-server localhost:9092 --topic dbserver1.inventory.customers

### Insert row into MySQL
INSERT INTO customers VALUES (default, "Kenneth", "Anderson", "kander@acme.com");


## Notes
### Delete Kafka Topic(s)
./kafka-topics.sh --bootstrap-server=localhost:9092 --delete --topic my_connect_statuses

### Consumer Kafka Topic
./kafka-console-consumer.sh  --bootstrap-server localhost:9092 --topic dbserver1.inventory.customers


