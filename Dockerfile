FROM node:12-alpine

RUN apk update && apk add --no-cache git sqlite

RUN git clone https://github.com/Cryptkeeper/Minetrack.git

WORKDIR /Minetrack

RUN git checkout prod

RUN npm install && npm run build

RUN chmod +x scripts/start.sh

RUN mkdir /data && touch /data/database.sql
RUN ln -s /data/database.sql ./database.sql

ADD config.json config.json

ENTRYPOINT [ "/bin/sh", "-c", "/Minetrack/scripts/start.sh" ]
