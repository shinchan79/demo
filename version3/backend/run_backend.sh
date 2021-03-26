#!/bin/sh
mongod --fork --logpath /var/log/mongodb/mongod.log && java -Dspring.data.mongodb.uri=mongodb://localhost:27017/todoapp -jar /home/spring-boot-backend/target/todoapp-0.0.1-SNAPSHOT.jar