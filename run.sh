#!/usr/bin/env bash
# Run mongoDB as daemon and start the app
# mongod --fork --logpath /var/log/mongodb/mongod.log
#cd /home/angular-frontend
# npm start
pm2 --name demo start npm -- start
mongod --fork --logpath /var/log/mongodb/mongod.log && java -Dspring.data.mongodb.uri=mongodb://localhost:27017/todoapp -jar /home/spring-boot-backend/target/todoapp-0.0.1-SNAPSHOT.jar
