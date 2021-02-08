FROM ubuntu:20.04
	
## Install Java 8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Install MongoDB dependencies
RUN apt-get update && \
    apt-get install -y gnupg

## Install wget
RUN apt-get update && \
	apt-get install -y wget

## Install maven
RUN apt-get update && \
	apt-get install -y maven

## Install mongoDB 
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt-get update && \
	apt-get install -y mongodb-org

RUN mkdir -p /data/db
RUN mkdir -p /data/code
COPY ./mongod.conf /etc/init/mongod.conf

## Copy backend to container
COPY ./spring-boot-backend /home/spring-boot-backend
## Package the backend 
WORKDIR /home/spring-boot-backend
RUN  mongod --fork --logpath /var/log/mongodb/mongod.log && mvn package
# ## Copy jar file to container
# ADD ./todoapp-0.0.1-SNAPSHOT.jar ./todoapp-0.0.1-SNAPSHOT.jar

## Install npm to run front-end
RUN apt-get update && \
	apt-get install -y npm
COPY ./angular4-frontend/ /home/angular4-frontend
WORKDIR /home/angular4-frontend/
RUN npm install

## Install third-party tool to run angular app as daemon
RUN npm install pm2 -g

## Copy run config file to container and grant execute permission
COPY ./run.sh ./run.sh
RUN chmod +x ./run.sh

ENTRYPOINT ["./run.sh"]