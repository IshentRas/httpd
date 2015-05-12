# "ported" by IshentRas <william17.burton@gmail.com>
#
# Originally written for Fedora-Dockerfiles by
#   "Scott Collier" <scollier@redhat.com>

FROM centos:centos7
MAINTAINER IshentRas william17.burton@gmail.com

RUN yum -y update && yum -y install httpd mod_ssl && yum clean all

EXPOSE 80 443

# Simple startup script to avoid some issues observed with container restart 
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

ENTRYPOINT ["/run-httpd.sh"]
