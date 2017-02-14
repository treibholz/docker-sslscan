FROM alpine:3.5
MAINTAINER Klaus Umbach <klaus+docker@uxix.de>

RUN apk add --no-cache build-base git perl zlib-dev && \
    git clone -b 1.11.8-rbsec https://github.com/rbsec/sslscan.git && \
    cd sslscan && \
    sed -i -e 's!^WARNINGS\ \ =\ -Wall!WARNINGS\ \ =\ -Wall\ -Wno-misleading-indentation!' Makefile && \
    make static && make install && \
    cd / && rm -rf sslscan && \
    apk del  build-base git perl zlib-dev

USER nobody
ENTRYPOINT ["/usr/bin/sslscan"]
