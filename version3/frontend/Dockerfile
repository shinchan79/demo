FROM ubuntu:20.04
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Install npm to run front-end
RUN apt-get update && \
	apt-get install -y npm
COPY ./angular4-frontend/ /home/angular4-frontend
WORKDIR /home/angular4-frontend/
RUN npm install

## Copy run config file to container and grant execute permission
COPY ./run_frontend.sh ./run_frontend.sh
RUN chmod +x ./run_frontend.sh

EXPOSE 4200
ENTRYPOINT ["./run_frontend.sh"]

