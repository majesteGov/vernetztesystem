FROM debian:bookworm

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install iproute2 curl dumb-init 
RUN apt-get -y install net-tools iputils-ping 
RUN apt-get -y install haproxy
RUN apt-get -y install openssh-server
RUN apt-get -y install sudo vim

COPY myinit.sh /usr/bin
COPY haproxy.cfg /etc/haproxy/

ENTRYPOINT ["/usr/bin/dumb-init","--"]

CMD ["/usr/bin/myinit.sh"]

