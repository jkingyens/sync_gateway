FROM ubuntu:12.04
RUN apt-get update -q
RUN apt-get install -qy build-essential curl git
RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
RUN apt-get install -qy bc
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
ADD . /opt/sync_gateway
WORKDIR /opt/sync_gateway
RUN git submodule update --init
RUN make 
EXPOSE 4984 4985
CMD /opt/sync_gateway/bin/sync_gateway -interface=0.0.0.0:4984 -adminInterface=0.0.0.0:4985 -bucket=$BUCKET_NAME -dbname=$DB_NAME -url=http://$CB_PORT_3000_TCP_ADDR:$CB_PORT_3000_TCP_PORT /opt/config/config.json
