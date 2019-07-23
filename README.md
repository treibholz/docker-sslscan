# docker-sslscan

Selfcompiling static build of sslscan

Uses the fork [rbsec/sslscan](https://github.com/rbsec/sslscan)

Based on [Alpine Linux](https://alpinelinux.org/), so the image is quite small.

But to make it even smaller, I switched to a multi-stage build and only copy
the static sslscan-binary and an absolute minimal set of files from Alpine
Linux into an empty container.

## Usage:

I recommend to use the file sslscan.sh

```sh
#!/bin/sh

docker run \
    --rm=true --interactive --tty \
    treibholz/sslscan:latest "$@"
```

Then it's easy:

```
./sslscan.sh --help
```
