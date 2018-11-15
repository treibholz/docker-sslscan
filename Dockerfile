FROM alpine:3.8
MAINTAINER Klaus Umbach <klaus+docker@uxix.de>

ENV SSLSCAN_VERSION "1.11.12-rbsec"
ENV CFLAGS "-D__USE_GNU"

RUN apk add --no-cache --virtual .build-deps build-base git perl zlib-dev libc6-compat && \
    git clone --depth 1 -b $SSLSCAN_VERSION https://github.com/rbsec/sslscan.git && \
    cd sslscan && \
    make static && make install && \
    cd / && rm -rf sslscan && \
    apk del .build-deps

USER nobody
ENTRYPOINT ["/usr/bin/sslscan"]
