FROM debian

# https://hub.docker.com/r/jmferrer/apache2-reverse-proxy
MAINTAINER Jose Manuel Ferrer Mosteiro <jmferrer@paradigmadigital.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get -y install ansible python3-apt curl net-tools

COPY ansible/* /etc/ansible/

RUN ansible-playbook -i "localhost," -c local /etc/ansible/site.yml

RUN apt-get -y remove ansible python3-apt;apt-get -y autoremove

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "Listen 8080" > /etc/apache2/ports.conf
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080

EXPOSE 8443

CMD ["apache2-reverse-proxy"]