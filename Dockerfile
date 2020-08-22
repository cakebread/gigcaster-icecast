FROM ubuntu:18.04

# Based on https://github.com/Palakis/docker-icecast-kh
MAINTAINER Rob Cakebread <rob@cakebread.io>

ENV IC_VERSION "2.4.0-kh15"
ENV SYSCONF_DIR "/etc/icecast"

USER root

RUN useradd icecast

# tools
RUN apt-get -qq -y update && apt-get -qq -y install build-essential supervisor wget curl supervisor

# icecast
RUN apt-get -qq -y install libxml2-dev libxslt1-dev libogg-dev libvorbis-dev libflac-dev \
                           libtheora-dev libspeex-dev libopus-dev libssl-dev libcurl4-openssl-dev

RUN wget "https://github.com/cakebread/icecast-kh/releases/download/2.4.0-kh15/icecast-2.4.0-kh15.tar.gz" -O- | tar zxvf - && \
    cd "icecast-kh-icecast-$IC_VERSION" && mkdir $SYSCONF_DIR && \
    ./configure --with-curl --with-openssl --prefix=/usr --sysconfdir=$SYSCONF_DIR --localstatedir=/var && \
    make && make install

RUN rm -rvf "icecast-kh-icecast-$IC_VERSION" && rm -rf /var/lib/apt/lists/*
RUN apt-get autoclean && apt-get clean && apt-get autoremove

WORKDIR /home/icecast

EXPOSE 8000 9001

ENTRYPOINT ["supervisord", "-c", "/home/icecast/config/supervisord.conf"]

