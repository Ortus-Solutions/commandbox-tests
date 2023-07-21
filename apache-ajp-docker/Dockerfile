FROM debian

# https://hub.docker.com/r/jmferrer/apache2-reverse-proxy
MAINTAINER Jose Manuel Ferrer Mosteiro <jmferrer@paradigmadigital.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get -y install ansible python3-apt curl net-tools

COPY ansible/* /etc/ansible/

RUN ansible-playbook -i "localhost," -c local /etc/ansible/site.yml

RUN apt-get -y remove ansible python3-apt;apt-get -y autoremove

RUN echo "Listen 8080" > /etc/apache2/ports.conf
RUN echo "Listen 8081" >> /etc/apache2/ports.conf
RUN echo "Listen 8082" >> /etc/apache2/ports.conf
RUN echo "Listen 8083" >> /etc/apache2/ports.conf
RUN echo "Listen 8084" >> /etc/apache2/ports.conf
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf


COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080
EXPOSE 8081
EXPOSE 8082
EXPOSE 8083
EXPOSE 8084

EXPOSE 8443

CMD ["apache2-reverse-proxy"]