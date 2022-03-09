From ubuntu:16.04

LABEL maintainer.name="Eventdisplay Team"
LABEL maintainer.email="gernot.maier@desy.de"

# All software is installed here
WORKDIR workdir
ENV WORKDIR /workdir

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

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install hessioxx 
COPY hessioxxx.tar.gz .
RUN tar -xvzf hessioxxx.tar.gz && \
   cd hessioxxx && \
   make EXTRA_DEFINES="-DCTA_PROD4 -DMAXIMUM_TELESCOPES=180 -DWITH_GSL_RNG" && \
   cd .. && rm -f hessioxxx.tar.gz
ENV HESSIOSYS ${WORKDIR}/hessioxxx
ENV LD_LIBRARY_PATH "${HESSIOSYS}/lib:${LD_LIBRARY_PATH}"

# Install ROOT
RUN wget https://root.cern/download/root_v6.22.08.Linux-ubuntu16-x86_64-gcc5.4.tar.gz && \
    tar -xzf root_v6.22.08.Linux-ubuntu16-x86_64-gcc5.4.tar.gz && \
    rm -f root_v6.22.08.Linux-ubuntu16-x86_64-gcc5.4.tar.gz && \
    echo /opt/root/lib >> /etc/ld.so.conf && \
    ldconfig
ENV ROOTSYS ${WORKDIR}/root
ENV LD_LIBRARY_PATH "${ROOTSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${ROOTSYS}/bin:${PATH}

# Install Eventdisplay
ENV EVNDISPSYS ${WORKDIR}/Eventdisplay-5.6.8
ENV SOFASYS ${EVNDISPSYS}/sofa/
RUN wget https://github.com/Eventdisplay/Eventdisplay/archive/refs/tags/v5.6.8.zip && \
    unzip v5.6.8.zip && rm -f v5.6.8.zip && \
    cd ${EVNDISPSYS} && \
    ./install_sofa.sh && \
    make -j 4 evndisp CTA.convert_hessio_to_VDST printRunParameter logFile GRIDPROD=CTAGRID CTAPROD=PROD5 && \
    rm -f ${EVNDISPSYS}/obj/*.o

ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${EVNDISPSYS}/lib:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc

# Install Eventdisplay Analysis files
ENV OBS_EVNDISP_AUX_DIR ${WORKDIR}/Eventdisplay_AnalysisFiles_CTA
ENV CTA_EVNDISP_AUX_DIR ${WORKDIR}/Eventdisplay_AnalysisFiles_CTA
ENV OBS_USER_DATA_DIR /tmp/
RUN wget https://github.com/Eventdisplay/Eventdisplay_AnalysisFiles_CTA/archive/refs/tags/v1.5.3.zip && \
    unzip v1.5.3.zip && rm -f v1.5.3.zip && \
    mv -v Eventdisplay_AnalysisFiles_CTA-1.5.3 Eventdisplay_AnalysisFiles_CTA

# Copy run script 
COPY run.sh ${WORKDIR}
