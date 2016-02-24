FROM centos:centos7
MAINTAINER IshentRas william17.burton@gmail.com

RUN yum -y install --setopt=tsflags=nodocs httpd && yum clean all
# Switch 80 to non-default WKP (Well Known Port < 1024)
RUN find /etc/httpd/ -iname "*.conf" -exec sed -i -e 's/80/8080/g' {} \;
# Create tmp directory for PID creation
RUN ln -s /tmp/ /etc/httpd && echo "PidFile    "tmp/httpd.pid"" >> /etc/httpd/conf/httpd.conf
# Modify log directory to enable non-root user to write
RUN rm -rf /etc/httpd/logs && \
    mkdir -m 777 /etc/httpd/logs && \ 
    rm -rf /run/httpd && mkdir -m 777 /run/httpd

EXPOSE 8080

# Simple startup script to avoid some issues observed with container restart 
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

ENTRYPOINT ["/run-httpd.sh"]

