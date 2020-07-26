FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends kmod software-properties-common && \
    add-apt-repository ppa:linbit/linbit-drbd9-stack && \
    apt-get update -y && \
    apt-get remove --purge -y software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY scripts /scripts

ENV PROBE false

CMD ["/scripts/run.sh"]
