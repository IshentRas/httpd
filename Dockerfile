FROM centos

MAINTAINER William Burton "william17.burton@gmail.com"

RUN yum install -y epel-release && yum install -y nginx && yum clean all
RUN mkdir /etc/nginx/certs && /etc/pki/tls/certs/make-dummy-cert /etc/nginx/certs/localhost.crt 

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY ssl.conf /etc/nginx/conf.d/ssl.conf

#VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

<<<<<<< HEAD
ENTRYPOINT ["nginx"]
=======
ENTRYPOINT ["/usr/sbin/nginx"]
>>>>>>> branch 'master' of git@github.com:IshentRas/httpd.git
CMD ["-g", "daemon off;"]
