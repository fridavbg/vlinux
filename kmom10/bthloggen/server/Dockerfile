FROM node:8

WORKDIR /server

COPY package*.json ./

RUN npm install

COPY index.js routes.json ./

ENTRYPOINT [ "npm", "start" ]