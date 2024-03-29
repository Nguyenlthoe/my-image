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
RUN wget https://download.redis.io/redis-stable.tar.gz && tar -xzvf redis-stable.tar.gz

RUN cd ./redis-stable && make BUILD_TLS=no
RUN cd ./redis-stable && make install
RUN echo vm.overcommit_memory = 1 >> /etc/sysctl.conf
RUN sysctl vm.overcommit_memory=1
EXPOSE 6379

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]