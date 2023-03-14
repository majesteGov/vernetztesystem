FROM debian:bookworm

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y apache2 vim less tree html2text procps sudo w3m
RUN apt-get install -y dumb-init curl iproute2 mariadb-client openssh-server
RUN apt-get install -y iputils-ping net-tools inotify-tools 

RUN a2enmod proxy_http  rewrite cgi
COPY 000-default.conf /etc/apache2/sites-available/

COPY myinit.sh /usr/bin

ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/bin/myinit.sh"]
