FROM cloudfoundry/cflinuxfs2
MAINTAINER Leandro David Cacciagioni <leandro.21.2008@gmail.com>

# Here we try to declare all the env vars that the DEA normally expose
ENV DEBIAN_FRONTEND=noninteractive PORT=8080 VCAP_APP_PORT=8080 HOME=/home/vcap/app PWD=/home/vcap USER=vcap TMPDIR=/home/vcap/tmp VCAP_APP_HOST=0.0.0.0

# Here we will add the neccesary libs
RUN apt-get update && apt-get dist-upgrade && apt-get -qqy install git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT /entrypoint.sh

# Here we try to expose the default port
EXPOSE 8080

# We set the default working dir to the place where your app is
WORKDIR /home/vcap/app

VOLUME /object

# Here we add our code
ADD entrypoint.sh /entrypoint.sh

RUN mkdir /home/vcap/tmp && mkdir /buildpack && chmod 755 /entrypoint.sh
