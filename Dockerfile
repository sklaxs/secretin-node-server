FROM node:alpine

RUN apk add --no-cache --virtual .build-deps \
        curl \
        git

# PID 1 needs to handle process reaping and signals
# https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
RUN curl -L https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 > /usr/local/bin/dumb-init && chmod +x /usr/local/bin/dumb-init

RUN mkdir -p /secretin-server
WORKDIR /secretin-server

#COPY package.json /secretin-server
RUN curl -L https://github.com/secretin/secretin-server/blob/master/package.json > ./package.json
RUN ls
RUN pwd
RUN npm install

#COPY . /secretin-server
RUN git clone https://github.com/secretin/secretin-server.git

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD [ "npm", "start"]
