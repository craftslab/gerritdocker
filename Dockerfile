FROM ubuntu:20.04
MAINTAINER Gerrit Code Review Community

ARG NAME=gerrit
ARG UID=1000
ARG GID=1000

# Add Gerrit packages repository
RUN apt-get update && \
    apt-get -y install gnupg2
RUN echo "deb mirror://mirrorlist.gerritforge.com/bionic gerrit contrib" > /etc/apt/sources.list.d/GerritForge.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 847005AE619067D5

RUN apt-get update
RUN apt-key update
RUN apt-get -y install sudo

ADD entrypoint.sh /

# Install OpenJDK and Gerrit in two subsequent transactions
# (pre-trans Gerrit script needs to have access to the Java command)
RUN apt-get -y install openjdk-11-jdk
RUN apt-get -y install gerrit=3.3.3-1 && \
    apt-mark hold gerrit && \
    /entrypoint.sh init && \
    bash -c 'rm -f /var/gerrit/etc/{ssh,secure}* && rm -Rf /var/gerrit/{static,index,logs,data,index,cache,git,db,tmp}/*' && \
    groupmod -g $GID $NAME && \
    usermod -u $UID $NAME && \
    chown -R $NAME:$NAME /var/gerrit

# Configure timezone
RUN apt-get -y install locales && \
    cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

USER $NAME

ENV CANONICAL_WEB_URL=
ENV HTTPD_LISTEN_URL=

# Allow incoming traffic
EXPOSE 29418 8080

VOLUME ["/var/gerrit/git", "/var/gerrit/index", "/var/gerrit/cache", "/var/gerrit/db", "/var/gerrit/etc"]

ENTRYPOINT ["/entrypoint.sh"]

# Build for Gerrit UID/GID
ONBUILD USER root
ONBUILD ARG GERRIT_NAME=gerrit
ONBUILD ARG GERRIT_UID=1000
ONBUILD ARG GERRIT_GID=1000
ONBUILD RUN groupmod -g $GERRIT_GID $GERRIT_NAME && \
            usermod -u $GERRIT_UID $GERRIT_NAME && \
            chown -R $GERRIT_NAME:$GERRIT_NAME /var/gerrit
ONBUILD USER $GERRIT_NAME
