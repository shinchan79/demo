FROM ubuntu:20.04
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Install npm to run front-end
RUN apt-get update && \
	apt-get install -y npm
COPY ./angular4-frontend/ /home/angular4-frontend
WORKDIR /home/angular4-frontend/
RUN npm install

## Copy run config file to container and grant execute permission
RUN chmod +x ./run_frontend.sh
COPY ./run_frontend.sh /home/run_frontend.sh
#RUN chmod +x home/run_frontend.sh

EXPOSE 4200
ENTRYPOINT ["/home/run_frontend.sh"]

