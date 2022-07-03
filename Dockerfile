FROM ubuntu:22.04


RUN apt update && apt install -y git wget
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.101.0/hugo_0.101.0_Linux-64bit.tar.gz
RUN tar xvzf hugo_0.101.0_Linux-64bit.tar.gz
RUN mv /hugo /usr/bin/hugo

RUN wget https://github.com/filiph/linkcheck/releases/download/2.0.23/linkcheck-2.0.23-linux-x64.tar.gz
RUN tar xvzf linkcheck-2.0.23-linux-x64.tar.gz
RUN mv /linkcheck/linkcheck /usr/bin/linkcheck

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
