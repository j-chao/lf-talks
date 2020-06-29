curl -LvvvX POST "debezium-connect.my-kafka-project.svc:8083/connectors" \
  -H "Accept:application/json" -H "Content-Type:application/json" \
  -d '{
      "name": "inventory-connector",
      "config": {
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "tasks.max": "1",
        "database.hostname": "mysql",
        "database.port": "3306",
        "database.user": "mysqluser",
        "database.password": "mysqlpw",
        "database.server.id": "184054",
        "database.server.name": "dbserver1",
        "database.whitelist": "inventory",
        "database.history.kafka.bootstrap.servers": "my-cluster-kafka-bootstrap:9092",
        "database.history.kafka.topic": "dbhistory.inventory",
        "database.allowPublicKeyRetrieval":"true"
      }
    }'
