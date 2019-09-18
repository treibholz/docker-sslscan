FROM alpine:3.10.2

ENV SSLSCAN_VERSION "1.11.13-rbsec"
ENV CFLAGS "-D__USE_GNU"

RUN apk add --no-cache --virtual .build-deps build-base git perl zlib-dev libc6-compat binutils && \
    git clone --depth 1 -b $SSLSCAN_VERSION https://github.com/rbsec/sslscan.git && \
    cd sslscan && \
    make static && make install && \
    cd / && rm -rf sslscan && \
    strip /usr/bin/sslscan && \
    apk del .build-deps

# Start from scratch and only add what is really, really needed, to reduce the
# size of the image to the absolute minimum 

FROM scratch
MAINTAINER Klaus Umbach <klaus+docker@uxix.de>

COPY --from=0 /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=0 /lib/libz.so.1 /lib/libz.so.1
COPY --from=0 /etc/passwd /etc/passwd
COPY --from=0 /usr/bin/sslscan /sslscan
USER nobody
ENTRYPOINT ["/sslscan"]
