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

RUN groupadd -r jira -g 1000 && useradd -u 1000 -r -g jira -m -d /opt/atlassian -s /sbin/nologin -c "jira user" jira && \
    chmod 755 /opt/atlassian


RUN  chown -R jira:jira /opt/atlassian

RUN  chown -R jira:jira /var/atlassian/application-data/jira




EXPOSE 8080

#Specify the user which should be used to execute all commands below
USER jira

# Set the default command to run on boot
CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg"]
