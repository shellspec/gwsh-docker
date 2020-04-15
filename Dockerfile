FROM buildpack-deps:buster as builder
ENV DEBIAN_FRONTEND=noninteractive DEBCONF_NOWARNINGS=yes
RUN apt-get update
RUN VERSION=snapshot-20190627 \
 && URL=https://github.com/hvdijk/gwsh/archive/$VERSION.tar.gz \
 && wget -nv -O- --trust-server-names "$URL" | tar xzf - \
 && cd gwsh-$VERSION \
 && ./autogen.sh \
 && ./configure \
 && make install

FROM debian:buster-slim
COPY --from=builder /usr/local/bin* /usr/local/bin/
