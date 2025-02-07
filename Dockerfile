FROM amazonlinux:2023
ARG POSTGRES_VERSION

RUN yum update -y \
    && yum install -y \
    gzip \ 
    aws-cli 

RUN yum install -y postgresql${POSTGRES_VERSION}

WORKDIR /scripts

COPY backup.sh .
ENTRYPOINT [ "/scripts/backup.sh" ]
