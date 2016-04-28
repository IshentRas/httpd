FROM openshift/origin-base
MAINTAINER IshentRas william17.burton@gmail.com

RUN yum install -y nginx --setopt=tsflags=nodocs nginx && yum clean all
# Create dedicated directory for http (Allow non root user to access/modify) 
# Give the availabilty to run containers under random UID.

RUN mkdir -p -m 777 /opt/app-root/
#COPY ./contrib/ /usr/local/etc
#
## In order to drop the root user, we have to make some directories world
## writeable as OpenShift default security model is to run the container under
## random UID.
#RUN sed -i -f /usr/local/etc/httpdconf.sed /etc/httpd/conf/httpd.conf && \
#    rm -rf /run/httpd && mkdir -m 777 /run/httpd

EXPOSE 8080

ENTRYPOINT ["/usr/sbin/nginx"]
