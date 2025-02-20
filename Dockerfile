FROM registry.redhat.io/ubi7/ubi
#FROM registry.access.redhat.com/ubi7/ubi

RUN yum -y install --disableplugin=subscription-manager httpd24 rh-php72 rh-php72-php dracut-fips\
  && yum --disableplugin=subscription-manager clean all

ADD index.php /opt/rh/httpd24/root/var/www/html

RUN sed -i 's/Listen 80/Listen 8080/' /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf \
  && chgrp -R 0 /var/log/httpd24 /opt/rh/httpd24/root/var/run/httpd \
  && chmod -R g=u /var/log/httpd24 /opt/rh/httpd24/root/var/run/httpd
  
EXPOSE 8080

USER 1001

CMD scl enable httpd24 rh-php72 -- httpd -D FOREGROUND

