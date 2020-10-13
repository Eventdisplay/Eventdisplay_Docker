From ubuntu:20.04

LABEL maintainer.name="Eventdisplay Team"
LABEL maintainer.email="gernot.maier@desy.de"

# All software is installed here
WORKDIR evndisp
ENV EVNDISP /evndisp

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
  vim \
  wget \
  zstd
RUN apt-get clean

# Install hessioxx 
COPY hessioxxx.tar.gz .
RUN tar -xvzf hessioxxx.tar.gz && \
   cd hessioxxx && \
   make EXTRA_DEFINES="-DCTA_PROD4 -DMAXIMUM_TELESCOPES=180 -DWITH_GSL_RNG" && \
   cd .. && rm -f hessioxxx.tar.gz
ENV HESSIOSYS ${EVNDISP}/hessioxxx
ENV LD_LIBRARY_PATH "${HESSIOSYS}/lib:${LD_LIBRARY_PATH}"

# Install ROOT
RUN wget https://root.cern/download/root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    tar -xzf root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    rm -f root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
ENV ROOTSYS ${EVNDISP}/root
ENV LD_LIBRARY_PATH "${ROOTSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${ROOTSYS}/bin:${PATH}

# Install Eventdisplay
ENV EVNDISPSYS ${EVNDISP}/Eventdisplay-prod5-v07
ENV SOFASYS ${EVNDISPSYS}/sofa/
RUN wget https://github.com/Eventdisplay/Eventdisplay/archive/prod5-v07.zip && \
    unzip prod5-v07.zip && rm -f prod5-v07.zip && \
    cd ${EVNDISPSYS} && \
    ./install_sofa.sh && \
    make -j 2 evndisp CTA.convert_hessio_to_VDST printRunParameter logFile GRIDPROD=CTAGRID CTAPROD=PROD5 && \
    rm -f ${EVNDISPSYS}/obj/*.o

ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc

# Install Eventdisplay Analysis files
ENV OBS_EVNDISP_AUX_DIR ${EVNDISP}/Eventdisplay_AnalysisFiles_CTA-prod5-v07
ENV OBS_USER_DATA_DIR /tmp/
RUN wget https://github.com/Eventdisplay/Eventdisplay_AnalysisFiles_CTA/archive/prod5-v07.zip && \
    unzip prod5-v07.zip && \
    rm -f prod5-v07.zip

# Copy run script 
COPY run.sh ${EVNDISP}
