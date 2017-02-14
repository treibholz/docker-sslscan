#!/bin/sh

docker run \
    --rm=true --interactive --tty \
    treibholz/sslscan:latest "$@"

# vim:fdm=marker:ts=4:sw=4:sts=4:ai:sta:et
