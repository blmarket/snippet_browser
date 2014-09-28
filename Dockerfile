FROM ubuntu:14.04

MAINTAINER Jeong, Heon <blmarket@gmail.com>

RUN apt-get update
RUN apt-get -y install software-properties-common git build-essential
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y install nodejs

ADD dist /root/dist
ADD node_modules /root/dist/server/node_modules

WORKDIR /root/dist/server

EXPOSE 8080
ENV NODE_ENV production
CMD [ "node", "app.js" ]
