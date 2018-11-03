FROM afdaniele/lcm:1.4.0

# arguments
ARG INSTALL_DIR=/usr/local

# environment variables
ENV LIBBOT2_INSTALL_DIR $INSTALL_DIR

# build libbot2 from source
RUN mkdir -p /tmp/libbot2 && \
  # download libbot2
  wget --no-check-certificate https://github.com/ripl-ttic/libbot2/archive/master.tar.gz && \
  tar -zxvf master.tar.gz && \
  cd libbot2-master && \
  # install dependencies, then clean the apt cache
  ./scripts/setup/linux/ubuntu/$UBUNTU_DISTRIB_CODENAME/install_prereqs && \
  rm -rf /var/lib/apt/lists/* && \
  # build libbot2
  BUILD_PREFIX=$LIBBOT2_INSTALL_DIR make -j && \
  # remove source code
  cd / && \
  rm -rf /tmp/libbot2
