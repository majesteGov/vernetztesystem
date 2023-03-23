FROM debian:bookworm
RUN apt-get update && apt-get -y upgrade
RUN useradd -r tomcat
RUN apt-get -y install iproute2 curl dumb-init html2text w3m 
RUN apt-get -y install net-tools iputils-ping mariadb-client
RUN apt-get -y install openssh-server
RUN apt-get -y install inotify-tools
RUN apt-get -y install sudo vim less
RUN apt-get -y install openjdk-17-jdk
COPY download/apache-tomcat-10.1.4.tar.gz /opt
RUN cd /opt && tar -xf apache-tomcat-10.1.4.tar.gz && \
    mv /opt/apache-tomcat-10.1.4 /opt/tomcat && \
    chown -R tomcat: /opt/tomcat
COPY --chown=tomcat:tomcat tomcat-users.xml /opt/tomcat/conf
COPY --chown=tomcat:tomcat server.xml /opt/tomcat/conf
COPY --chown=tomcat:tomcat download/mariadb*jar /opt/tomcat/lib
COPY --chown=tomcat:tomcat download/postgres*jar /opt/tomcat/lib
COPY --chown=tomcat:tomcat context.xml /opt/tomcat/webapps/manager/META-INF/
RUN mkdir -m 770 /opt/tomcat/upload && chown tomcat: /opt/tomcat/upload
RUN mkdir -p -m 770 /data/upload && chown tomcat: /data/upload

COPY myinit.sh /usr/bin
ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/bin/myinit.sh"]

