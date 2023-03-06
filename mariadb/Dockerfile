FROM debian:bookworm
 
RUN apt-get update && apt-get -y upgrade 
#RUN apt-get -y install vim propcs less tree mariadb-server iproute2 
RUN apt-get -y install html2text sudo less tree iproute2
RUN apt-get -y install curl w3m mariadb-server vim
RUN apt-get -y install dumb-init
 
COPY myinit.sh /usr/bin 

ENTRYPOINT ["/usr/bin/dumb-init","--"] 

CMD ["/usr/bin/myinit.sh"]
