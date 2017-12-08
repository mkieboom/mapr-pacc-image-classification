# Image classification using YOLOv2 on MapR PACC
#
# VERSION 0.1 - not for production, use at own risk
#

#
# Using MapR PACC as the base image
# For specific versions check: https://hub.docker.com/r/maprtech/pacc/tags/
FROM maprtech/pacc

MAINTAINER mkieboom@mapr.com

RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm && \
    yum -y install epel-release git gcc python36u python36u-pip python36u-devel && \
    yum clean all && \
    rm -rf /var/cache/yum

# Install python
#RUN apk upgrade --no-cache \
#  && apk add --no-cache \
#    musl \
#    build-base \
#    python3 \
#    bash \
#    git \
#  && pip3 install --no-cache-dir --upgrade pip \
#  && rm -rf /var/cache/* \
#  && rm -rf /root/.cache/*

# Install pip
#RUN yum -y install epel-release && yum clean all
#RUN yum -y install python3 && yum clean all
#RUN yum -y install python3-pip && yum clean all
#RUN curl https://bootstrap.pypa.io/get-pip.py | python

# Install tensorflow
RUN pip3.6 install --upgrade tensorflow

# Install darknet
RUN pip3.6 install cython
RUN pip3.6 install opencv-python
RUN git clone https://github.com/thtrieu/darkflow
RUN pip3.6 install -e darkflow/

WORKDIR /darkflow/
CMD sudo flow --imgdir $YOLO_INPUT --model $YOLO_CONFIG --load $YOLO_WEIGHTS --threshold 0.1 --json
CMD /bin/bash


