FROM ubuntu:20.04

ENV TZ=Asia/Ho_Chi_Minh
ENV DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR /

RUN apt-get update
RUN apt-get install -y \
    curl \
    net-tools \
    iputils-ping \
    nano \
    ssh \
    make \
    gcc \
    pkg-config \
    openssl \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN apt-get update && apt-get install -y openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $PATH:$JAVA_HOME/bin

WORKDIR /opt

RUN wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-7.0.8.tgz && tar -xvzf mongodb-linux-x86_64-ubuntu2004-7.0.8.tgz && rm  mongodb-linux-x86_64-ubuntu2004-7.0.8.tgz

RUN mv mongodb-linux-x86_64-ubuntu2004-7.0.8 mongodb-server
RUN ln -s  /opt/mongodb-server/bin/* /usr/local/bin/

RUN wget https://downloads.mongodb.com/compass/mongodb-mongosh_2.2.4_amd64.deb
RUN apt install ./mongodb-mongosh_2.2.4_amd64.deb
RUN rm mongodb-mongosh_2.2.4_amd64.deb

RUN mkdir -p /var/lib/mongo
RUN mkdir -p /var/log/mongodb
COPY ./mongod.conf ./
EXPOSE 27017

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]