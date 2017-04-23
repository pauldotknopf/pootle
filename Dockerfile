FROM ubuntu:16.04
MAINTAINER Paul Knopf "pauldotknopf@gmail.com"

ENV POOTLE_VERSION="2.8.0rc5"

RUN apt-get update --quiet

# Install apt packages
RUN apt-get install --quiet -y \
  supervisor \
  python-pip \
  locales

RUN apt-get clean

RUN locale-gen en_US
RUN locale-gen en_US.UTF-8

RUN pip install --pre --process-dependency-links Pootle==$POOTLE_VERSION

COPY pootle.conf /root/.pootle/pootle.conf

WORKDIR /home/pootle

RUN apt-get install -y locales

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
EXPOSE 8080