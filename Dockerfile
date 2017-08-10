FROM crystallang/crystal:0.23.1

ADD . /project
WORKDIR /project

RUN shards build schlauer_typ

EXPOSE 3000
CMD bin/schlauer_typ -b localhost -p 3000
