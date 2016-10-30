FROM debian:jessie

MAINTAINER Henrik Jonsson <me@hkjn.me>

RUN apt-get autoclean && \
    apt-get autoremove && \
    apt-get update && \
    apt-get -qqy install --no-install-recommends ca-certificates cmake \
      build-essential libboost-all-dev git && \
    mkdir -p /src/ && \
    cd /src && \
    git clone https://github.com/nicehash/nheqminer.git && \
    mkdir nheqminer/nheqminer/build && \
    cd nheqminer/nheqminer/build && \
    cmake .. && \
    make && \
    rm -rf /var/lib/apt/lists/* && \
    adduser --uid 1000 --system nh && \
    chown -R nh /home/nh && \
    /usr/bin/install -c nheqminer -t /usr/local/bin/ && \
    rm -rf /src/nheqminer && \
    echo "Success"

USER nh

WORKDIR /home/nh
