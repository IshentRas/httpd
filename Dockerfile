FROM openshift/origin-base
MAINTAINER IshentRas william17.burton@gmail.com

RUN yum install -y nginx --setopt=tsflags=nodocs && yum clean all
# change default port to 8080 and forward request and error logs to docker log collector
RUN sed -i 's/80/8080/g;s/pid.*/pid \/tmp\/nginx.pid\;/g;/user nginx/d' /etc/nginx/nginx.conf && \
    rm -rf /var/lib/nginx && mkdir -p /var/lib/nginx/tmp && chmod 777 /var/lib/nginx/tmp && \
    rm -rf /var/log/nginx && mkdir /var/log/nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
