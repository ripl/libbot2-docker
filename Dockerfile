# Parameters
ARG REPO_NAME="libbot2-docker"
ARG DESCRIPTION="Contains the libbot libraries and executables"
ARG MAINTAINER="Matthew Walter (mwalter@ttic.edu)"

ARG UBUNTU_VERSION=20.04

# Base image
FROM ripl/lcm:$UBUNTU_VERSION

# arguments
ARG INSTALL_DIR=/usr/local

# environment variables
ENV LIBBOT2_INSTALL_DIR $INSTALL_DIR

# update apt lists and install system libraries, then clean the apt cache
RUN apt update && apt install -y \
    #lsb-release \
    build-essential \
    default-jdk \
    doxygen \
    file \
    freeglut3-dev \
    libgtk-3-dev \
    libxmu-dev \
    libjpeg8-dev \
    python3-numpy \
    python3-scipy \
    && rm -rf /var/lib/apt/lists/*

# build libbot2 from source
RUN mkdir -p /tmp/libbot2 && \
  cd /tmp/libbot2 && \
  # download libbot2
  wget https://github.com/ripl-ttic/libbot2/archive/master.tar.gz && \
  tar -zxvf master.tar.gz && \
  cd libbot2-master && \
  # install dependencies, then clean the apt cache
  #UBUNTU_DISTRIB_CODENAME=$(lsb_release -c -s) && \
  #./scripts/setup/linux/ubuntu/$UBUNTU_DISTRIB_CODENAME/install_prereqs && \
  #rm -rf /var/lib/apt/lists/* && \
  cd .. && \
  mkdir libbot2-build 
  
#   && \
#   # build libbot2
#   cd libbot2-build && \
#   cmake -DCMAKE_INSTALL_PREFIX=$LIBBOT2_INSTALL_DIR ../libbot2-master && \
#   make install && \
#   # remove source code
#   cd / && \
#   rm -rf /tmp/libbot2