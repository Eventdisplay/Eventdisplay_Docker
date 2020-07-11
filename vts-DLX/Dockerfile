From ubuntu:20.04

LABEL maintainer.name="Eventdisplay Team"
LABEL maintainer.email="gernot.maier@desy.de"

# force ubunto to use bash for /bin/sh
# (otherwise trouble with many evndisp scripts)
RUN yes no | dpkg-reconfigure dash

# Basic packages
RUN apt-get update && apt-get install -y \
  bash \
  gcc \
  g++ \
  git \
  libblas-dev \
  libfreetype6 \
  libxpm4 \
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

# Install VBF
COPY VBF-0.3.4.tar.gz .
RUN tar -xvzf VBF-0.3.4.tar.gz && \
   cd VBF-0.3.4  && \
   ./configure --prefix=${EVNDISP}/vbf && \
   make && make install && \
   cd .. && rm -f VBF-0.3.4.tar.gz
ENV VBFSYS ${EVNDISP}/vbf/
ENV PATH ${VBFSYS}/bin:${PATH}
ENV LD_LIBRARY_PATH "${VBFSYS}/lib:${LD_LIBRARY_PATH}"

# Install Eventdisplay
ENV EVNDISPSYS ${EVNDISP}/Eventdisplay/
ENV SOFASYS ${EVNDISPSYS}/sofa/
RUN git clone https://github.com/Eventdisplay/Eventdisplay.git && \
    cd ${EVNDISPSYS} && \
    ./install_sofa.sh && \
    make -j 2 printRunParameter logFile 

ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc

# Install Eventdisplay Analysis files
#ENV OBS_EVNDISP_AUX_DIR ${EVNDISP}/Eventdisplay_AnalysisFiles_CTA-prod5-v1.0
#ENV OBS_USER_DATA_DIR /tmp/
#RUN wget https://github.com/Eventdisplay/Eventdisplay_AnalysisFiles_CTA/archive/prod5-v1.0.tar.gz && \
#    tar -xzf prod5-v1.0.tar.gz && \
#    rm -f prod5-v1.0.tar.gz

# Copy run script 
#COPY run.sh ${EVNDISP}
