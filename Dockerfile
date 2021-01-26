FROM docker.io/fedora:28

MAINTAINER \
[Nikolaj Majorov <nikolaj@majorov.biz>]
ENV TZ=Europe/Berlin
ENV JIRA_INSTALL_DIR  /opt/atlassian/jira


RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
## Get all updates and install our minimal httpd server
RUN dnf update -y &&  \
dnf install -y  unzip zip hostname iputils && \
dnf clean all
COPY atlassian-installed.zip /tmp/atlassian-installed.zip
RUN unzip  /tmp/atlassian-installed.zip  -d /opt/ && rm -f /tmp/atlassian-installed.zip

RUN mkdir -p /var/atlassian/application-data/jira

RUN groupadd jira  && \
useradd -s /bin/bash -d  /opt/atlassian/jira  -m -g jira jira




RUN  chown -R jira:jira /opt/atlassian

RUN  chown -R jira:jira /var/atlassian/application-data/jira


# Switch back to jboss user
USER jira


EXPOSE 8080 3306


# Set the default command to run on boot
CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg"]
