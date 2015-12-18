FROM registry.domain.local/enc4u/httpd

USER root
EXPOSE 8080

# Labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for serving static HTML files" \
      io.k8s.display-name="httpd 2.4.6-40" \
      io.openshift.expose-services="8080:http" 


# Defines the location of the S2I to make it clear why the following COPY operation is happening
LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i

COPY ./index.hml /opt/app-root/src/index.hml

# This default user is created in the openshift/base-centos7 image
USER 1001

# Set the default CMD for the image
CMD ["/usr/local/s2i/run"]

