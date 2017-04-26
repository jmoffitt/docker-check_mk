# Docker version 1.13.0-rc5
# v 1.1.2

FROM ubuntu:xenial
MAINTAINER J. Patrick Moffitt (zuryn@zuryn.net)
# Maintainer is a relative term in this case

RUN apt-get update

ADD https://mathias-kettner.de/support/1.2.8p21/check-mk-raw-1.2.8p21_0.xenial_amd64.deb /root/

RUN dpkg -i /root/check-mk-raw-1.2.8p21_0.xenial_amd64.deb
RUN apt-get -f install
RUN apt-get upgrade
RUN echo "ServerName $HOSTNAME" >> /etc/apache2/apache2.conf
RUN omd create check_mk

EXPOSE 80

VOLUME [/opt/omd/check_mk]

ENTRYPOINT ["/usr/bin/omd start check_mk"]
