FROM centos:centos7
MAINTAINER IshentRas william17.burton@gmail.com

RUN yum -y install --setopt=tsflags=nodocs httpd && yum clean all
# Create dedicated directory for http (Allow non root user to access/modify) 
# Give the availabilty to run containers under random UID.

RUN mkdir -p -m 777 /opt/app-root/
COPY ./contrib/ /usr/local/etc

# In order to drop the root user, we have to make some directories world
# writeable as OpenShift default security model is to run the container under
# random UID.
RUN sed -i -f /usr/local/etc/httpdconf.sed /etc/httpd/conf/httpd.conf && \
    rm -rf /run/httpd && mkdir -m 777 /run/httpd

EXPOSE 8081

# Simple startup script to avoid some issues observed with container restart 
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

ENTRYPOINT ["/run-httpd.sh"]
