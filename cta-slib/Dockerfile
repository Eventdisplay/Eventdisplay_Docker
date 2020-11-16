From ubuntu:20.04

LABEL maintainer.name="Eventdisplay Team"
LABEL maintainer.email="gernot.maier@desy.de"

# force ubunto to use bash for /bin/sh
# (otherwise trouble with many evndisp scripts)
RUN yes no | dpkg-reconfigure dash

# Basic packages
RUN apt-get update && apt-get install -y \
  bash \
  bzip2 \
  gcc \
  g++ \
  git \
  libblas-dev \
  libbz2-dev \
  libfreetype6 \
  libxpm4 \
  libtiff-dev \
  libxtst6 \
  make \
  unzip \
  vim \
  wget \
  zstd
RUN apt-get clean

# Introduce user evndisp - stop being root
ARG username=evndisp
RUN useradd --create-home --home-dir /home/${username} ${username}
USER ${username}
WORKDIR /home/${username}
ENV EVNDISP /home/${username}

# Install ROOT
RUN wget https://root.cern/download/root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    tar -xzf root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    rm -f root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
ENV ROOTSYS ${EVNDISP}/root
ENV LD_LIBRARY_PATH "${ROOTSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${ROOTSYS}/bin:${PATH}

# Install Eventdisplay
ENV EVNDISPSYS ${EVNDISP}/Eventdisplay/
ENV SOFASYS ${EVNDISPSYS}/sofa/
RUN wget https://github.com/Eventdisplay/Eventdisplay/archive/master.zip && \
    unzip master.zip && rm -f master.zip && \
    mv -f Eventdisplay-master Eventdisplay && \
    cd ${EVNDISPSYS} && ls -l && ./install_sofa.sh && \
    make -j 2 slib && strip -g lib/libVAnaSum.so &&  \
    rm -f obj/*.o obj/*.cpp

ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc

# Install Eventdisplay Analysis files
RUN wget https://github.com/Eventdisplay/Eventdisplay_AnalysisFiles_CTA/archive/master.zip && \
    unzip master.zip && \
    mv -f Eventdisplay_AnalysisFiles_CTA-master Eventdisplay_AnalysisFiles_CTA && \
    rm -f master.zip
ENV CTA_EVNDISP_AUX_DIR /home/${username}/Eventdisplay_AnalysisFiles_CTA/
