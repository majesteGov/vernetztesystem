FROM debian:bookworm
RUN ls
RUN apt-get update && apt-get -y upgrade
RUN useradd -r tomcat
RUN apt-get -y install iproute2 curl dumb-init html2text w3m openjdk-17-jdk 
RUN apt-get -y install net-tools iputils-ping mariadb-client redis-tools postgresql-client
RUN apt-get -y install openssh-server inotify-tools vim 

COPY myinit.sh /usr/bin

ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/bin/myinit.sh"]

