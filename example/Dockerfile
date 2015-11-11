FROM hypriot/rpi-node:4.1-slim

RUN mkdir /app

WORKDIR /app

ADD . /app

RUN npm install -y -g nodemon \
    gulp

RUN npm install
