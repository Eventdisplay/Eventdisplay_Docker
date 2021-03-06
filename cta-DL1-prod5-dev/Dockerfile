From ubuntu:20.04

LABEL maintainer.name="Eventdisplay Team"
LABEL maintainer.email="gernot.maier@desy.de"

# All software is installed here
WORKDIR evndisp
ENV EVNDISP /data/

# Basic packages
RUN apt-get update && apt-get install -y \
  bash \
  gcc \
  g++ \
  libblas-dev \
  libfreetype6 \
  libxpm4 \
  libxtst6 \
  make \
  unzip \
  valgrind \
  vim \
  wget \
  zstd

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install hessioxx 
COPY hessioxxx.tar.gz .
RUN tar -xvzf hessioxxx.tar.gz && \
   cd hessioxxx && \
   make EXTRA_DEFINES="-DCTA_PROD4 -DMAXIMUM_TELESCOPES=180 -DWITH_GSL_RNG" && \
   cd .. && rm -f hessioxxx.tar.gz
ENV HESSIOSYS /evndisp/hessioxxx
ENV LD_LIBRARY_PATH "${HESSIOSYS}/lib:${LD_LIBRARY_PATH}"

# Install ROOT
RUN wget https://root.cern/download/root_v6.22.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    tar -xzf root_v6.22.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    rm -f root_v6.22.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
ENV ROOTSYS /evndisp/root
ENV LD_LIBRARY_PATH "${ROOTSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${ROOTSYS}/bin:${PATH}

# Install Eventdisplay
ENV EVNDISPSYS ${EVNDISP}/code/
ENV SOFASYS ${EVNDISPSYS}/sofa/

ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${EVNDISPSYS}/lib:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc

# Install Eventdisplay Analysis files
ENV OBS_EVNDISP_AUX_DIR ${EVNDISP}/Eventdisplay_AnalysisFiles_CTA/
ENV OBS_USER_DATA_DIR /tmp/

# Copy run script 
COPY run.sh /evndisp/
