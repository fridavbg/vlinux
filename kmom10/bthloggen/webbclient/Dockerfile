FROM ubuntu:22.04

RUN apt update && apt install -y apache2 w3m tree

COPY kmom10.vlinux.se.conf /etc/apache2/sites-available/kmom10.vlinux.se.conf

RUN a2ensite kmom10.vlinux.se.conf

RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

CMD apachectl -D FOREGROUND