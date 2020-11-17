FROM alpine:latest

ARG GOBGP_VERSION=v2.21.0

RUN apk update && \
    apk add linux-headers tini git go && \
    mkdir /src && \
    cd /src && \
    git clone https://github.com/osrg/gobgp && \
    cd gobgp && \
    git checkout $GOBGP_VERSION && \
    go mod download && \
    go build -o /usr/local/bin/gobgp ./cmd/gobgp && \
    go build -o /usr/local/bin/gobgpd ./cmd/gobgpd

ENTRYPOINT [ "/sbin/tini", "--", "gobgpd", "-f", "/etc/gobgp/gobgpd.toml" ]


