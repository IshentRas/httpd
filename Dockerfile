FROM centos

MAINTAINER William Burton "william17.burton@gmail.com"

RUN yum install -y epel-release && yum install -y nginx && yum clean all
RUN mkdir /etc/nginx/certs && /etc/pki/tls/certs/make-dummy-cert /etc/nginx/certs/localhost.crt 

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY ssl.conf /etc/nginx/conf.d/ssl.conf

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;"]
