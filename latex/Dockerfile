FROM debian:bookworm
RUN ls
RUN apt-get update && apt-get -y upgrade
RUN useradd -r tomcat
RUN apt-get -y install iproute2 curl dumb-init html2text w3m 
RUN apt-get -y install net-tools iputils-ping mariadb-client redis-tools postgresql-client
RUN apt-get -y install openssh-server
RUN apt-get -y install inotify-tools
RUN apt-get -y install openjdk-17-jdk
RUN apt-get -y install texlive-full
RUN apt-get -y install vim less qrencode zint qpdf pdftk bc
RUN apt-get -y install locales
RUN apt-get -y install apache2

RUN a2enmod proxy_http rewrite cgi

RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
RUN cat /etc/locale.gen
RUN locale-gen
RUN echo "LANG=en_US.UTF-8" > /etc/default/locale 
RUN mtxrun --script fonts --reload

COPY poppins/ /usr/share/fonts/poppins
COPY lora/ /usr/share/fonts/lora
COPY myinit.sh /usr/bin

ENTRYPOINT ["/usr/bin/dumb-init","--"]

CMD ["/usr/bin/myinit.sh"]

