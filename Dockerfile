# "ported" by IshentRas <william17.burton@gmail.com>
#
# Originally written for Fedora-Dockerfiles by
#   "Scott Collier" <scollier@redhat.com>

FROM centos:centos7
MAINTAINER IshentRas william17.burton@gmail.com

RUN yum -y update && yum -y install httpd mod_ssl && yum clean all
# Switch 80 & 443 to non-default WKP (Well Known Port < 1024)
RUN find /etc/httpd/ -iname "*.conf" -exec sed -i -e 's/80/8080/g' -e 's/443/4443/g' {} \;

EXPOSE 8080 4443

# Simple startup script to avoid some issues observed with container restart 
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

ENTRYPOINT ["/run-httpd.sh"]
