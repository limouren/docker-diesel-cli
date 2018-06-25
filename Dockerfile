FROM rust:1.27.0 AS builder

ENV DIESEL_CLI_VERSION 1.3.1

RUN cargo install diesel_cli --version ${DIESEL_CLI_VERSION}


FROM debian:stretch-slim

RUN apt-get update && \
    apt-get install -y \
    libpq-dev=9.6.7-0+deb9u1 \
    default-libmysqlclient-dev=1.0.2 \
    libsqlite3-dev=3.16.2-5+deb9u1 && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/diesel /bin/diesel

WORKDIR /usr/src

CMD [ "diesel" ]
