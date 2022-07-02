FROM alpine:3

RUN apk update && apk add coreutils git py3-pip
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.101.0/hugo_0.101.0_Linux-64bit.tar.gz
RUN tar xvzf hugo_0.101.0_Linux-64bit.tar.gz
RUN mv /hugo /usr/bin/hugo
RUN pip3 install linkchecker
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
