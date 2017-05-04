# Docker version 1.13.0-rc5
# v 1.1.2

FROM ubuntu:xenial
MAINTAINER J. Patrick Moffitt (jmoffitt@rimrockcapital.com)
# Maintainer is a relative term in this case

RUN apt-get update
RUN apt-get -y install apache2 apache2-bin apache2-data apache2-utils bind9-host binutils cron curl dbus debugedit dialog dnsutils file fontconfig fontconfig-config fonts-dejavu-core fonts-liberation fping freeradius-common freeradius-utils geoip-database graphviz gsfonts ifupdown iproute2 isc-dhcp-client isc-dhcp-common krb5-locales lcab libapache2-mod-fcgid libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap libarchive13 libart-2.0-2 libasn1-8-heimdal libatm1 libavahi-client3 libavahi-common-data libavahi-common3 libbind9-140 libbsd0 libcairo2 libcap-ng0 libcdt5 libcgraph6 libcups2 libcurl3-gnutls libdatrie1 libdbi-perl libdbi1 libdbus-1-3 libdns-export162 libdns162 libedit2 libelf1 libestr0 libevent-1.4-2 libexpat1 libffi6 libfile-copy-recursive-perl libfontconfig1 libfreeradius2 libfreetype6 libgd3 libgdbm3 libgeoip1 libglib2.0-0 libglib2.0-data libgmp10 libgnutls30 libgraphite2-3 libgsf-1-114 libgsf-1-common libgssapi-krb5-2 libgssapi3-heimdal libgvc6 libgvpr2 libharfbuzz0b libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhogweed4 libhx509-5-heimdal libice6 libicu55 libisc-export160 libisc160 libisccc140 libisccfg140 libjbig0 libjpeg-turbo8 libjpeg8 libjson-c2 libk5crypto3 libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 liblcms2-2 libldap-2.4-2 libldb1 libltdl7 liblua5.1-0 liblua5.2-0 liblwres141 liblzo2-2 libmagic1 libmcrypt4 libmnl0 libnet-snmp-perl libnettle6 libnspr4 libnss3 libnss3-nssdb libp11-kit0 libpango-1.0-0 libpango1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpangox-1.0-0 libpangoxft-1.0-0 libpathplan4 libpcap0.8 libpci3 libperl5.22 libpixman-1-0 libpng12-0 libpoppler58 libpopt0 libpython-stdlib libpython2.7 libpython2.7-minimal libpython2.7-stdlib libreadline5 libroken18-heimdal librpm3 librpmbuild3 librpmio3 librpmsign3 librtmp1 libsasl2-2 libsasl2-modules libsasl2-modules-db libsensors4 libsm6 libsmbclient libsnmp-base libsnmp-perl libsnmp30 libsqlite3-0 libtalloc2 libtasn1-6 libtdb1 libtevent0 libthai-data libthai0 libtiff5 libtirpc1 libvpx3 libwbclient0 libwebp5 libwebpmux1 libwind0-heimdal libwrap0 libx11-6 libx11-data libxau6 libxaw7 libxcb-render0 libxcb-shm0 libxcb1 libxdmcp6 libxext6 libxft2 libxml2 libxmu6 libxpm4 libxrender1 libxslt1.1 libxt6 libxtables11 logrotate mime-support netbase patch perl perl-modules-5.22 php-cgi php-cli php-common php-gd php-mcrypt php-pear php-sqlite3 php-xml php7.0-cgi php7.0-cli php7.0-common php7.0-gd php7.0-json php7.0-mcrypt php7.0-opcache php7.0-readline php7.0-sqlite3 php7.0-xml poppler-utils psmisc pyro python python-cffi-backend python-crypto python-cryptography python-enum34 python-idna python-imaging python-ipaddress python-ldap python-ldb python-minimal python-netsnmp python-openssl python-pil python-pkg-resources python-pyasn1 python-renderpm python-reportlab python-reportlab-accel python-samba python-six python-talloc python-tdb python2.7 python2.7-minimal rename rpcbind rpm rpm-common rpm2cpio rsync rsyslog samba-common samba-common-bin samba-libs sgml-base shared-mime-info smbclient snmp ssl-cert tcpd time traceroute tzdata ucf unzip update-inetd x11-common xdg-user-dirs xinetd xml-core

ADD https://mathias-kettner.de/support/1.2.8p21/check-mk-raw-1.2.8p21_0.xenial_amd64.deb /root/

VOLUME /opt/omd

RUN dpkg -i /root/check-mk-raw-1.2.8p21_0.xenial_amd64.deb

RUN apt-get -y upgrade
RUN echo "ServerName $HOSTNAME" >> /etc/apache2/apache2.conf
RUN omd create check_mk

RUN omd umount check_mk
RUN omd config check_mk set TMPFS off
RUN omd start check_mk

#RUN sed -i 's/80/8888/g' /etc/apache2/sites-available/000-default.conf
#RUN sed -i 's/80/8888/g' /etc/apache2/ports.conf

EXPOSE 80

CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["apachectl"]
