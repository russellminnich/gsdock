# goodsync/Dockerfile

FROM alpine:latest
MAINTAINER And Grin <grin@grin.ly>

# install glibc
RUN apk --no-cache --update add ca-certificates wget tar && \
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
	wget -nv https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && \
	apk add glibc-2.25-r0.apk

# install goodsync server
WORKDIR /gs
RUN wget -nv -O - https://www.goodsync.com/download/goodsync-release-x86_64.tar.gz | tar xzf - --strip-components=1

COPY rootfs /

EXPOSE 33333
EXPOSE 11000

CMD ["/gs/gsserver.sh"]
