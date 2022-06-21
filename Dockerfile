FROM arm32v7/debian:buster-slim

# build ARM on AMD64
COPY qemu-arm-static /usr/bin

# set variables and locales
ENV \
    LANG="C.UTF-8"

# install packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    ca-certificates \
    git \
    python3 \
    python3-can \
    python3-influxdb \
    python3-serial \
    python3-mysqldb \
    python3-paho-mqtt \
    python3-pika \
    python3-requests \
    python3-urllib3 \
    && rm -rf /var/lib/apt/lists/*

# install pyHPSU
RUN cd /opt \
    && git clone https://github.com/N3rdix/pyHPSUmqtt.git \
    && cd /opt/pyHPSU \
    && chmod +x install.sh \
    && sh install.sh

# expose volume
VOLUME /etc/pyHPSU

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
