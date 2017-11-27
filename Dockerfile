FROM debian:buster-slim

RUN apt-get update
RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs
RUN apt-get -y install -y git
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /secretin-server
WORKDIR /secretin-server

#COPY package.json /secretin-server
RUN mkdir tmp
RUN git clone https://github.com/secretin/secretin-server.git tmp/
RUN mv tmp/package.json package.json
RUN npm install

RUN git clone https://github.com/secretin/secretin-server.git

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD [ "npm", "start"]
