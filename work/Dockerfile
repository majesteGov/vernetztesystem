FROM debian:bookworm

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install iproute2 curl dumb-init html2text w3m 
RUN apt-get -y install net-tools mariadb-client
RUN apt-get -y install ncat redis-tools passwd
RUN apt-get -y install vim tree man openjdk-17-jdk openssh-server time sudo
RUN apt-get -y install htop inotify-tools sudo iputils-ping 

COPY myinit.sh /usr/bin

ENTRYPOINT ["/usr/bin/dumb-init","--"]

CMD ["/usr/bin/myinit.sh"]

