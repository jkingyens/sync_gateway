FROM ubuntu:12.04
RUN apt-get update -q
RUN apt-get install -qy build-essential curl git
RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
RUN apt-get install -qy bc
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
ADD . /opt/sync_gateway
RUN cd /opt/sync_gateway && ./build.sh
EXPOSE 4984 4985
ENTRYPOINT ["/opt/sync_gateway/bin/sync_gateway", "/opt/config/config.json"]
CMD []
