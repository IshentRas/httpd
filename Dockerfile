FROM 172.30.233.197:5000/test/httpd:latest
MAINTAINER IshentRas william17.burton@gmail.com

RUN yum clean all

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

