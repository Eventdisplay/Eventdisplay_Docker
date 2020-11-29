From rootproject/root:6.22.02-ubuntu20.04

# force ubunto to use bash for /bin/sh
# (otherwise trouble with many evndisp scripts)
RUN yes no | dpkg-reconfigure dash

## Basic packages
RUN apt-get update && apt-get install -y \
   git
#  bash \
#  bzip2 \
#  gcc \
#  g++ \
#  git \
#  libblas-dev \
#  libbz2-dev \
#  libfreetype6 \
#  libxpm4 \
#  libxtst6 \
#  make \
#  unzip \
#  vim \
#  wget \
#  zstd
RUN apt-get clean
#
## Introduce user evndisp - stop being root
ARG username=evndisp
RUN useradd --create-home --home-dir /home/${username} ${username}
USER ${username}
WORKDIR /home/${username}
ENV EVNDISP /home/${username}
#
## Install ROOT
#RUN wget https://root.cern/download/root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
#    tar -xzf root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
#    rm -f root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
#ENV ROOTSYS ${EVNDISP}/root
#ENV LD_LIBRARY_PATH "${ROOTSYS}/lib/:${LD_LIBRARY_PATH}"
#ENV PATH ${ROOTSYS}/bin:${PATH}
#
## Install VBF
COPY VBF-0.3.4.tar.gz .
RUN tar -xvzf VBF-0.3.4.tar.gz && \
   cd VBF-0.3.4  && \
   ./configure --prefix=${EVNDISP}/vbf && \
   make && make install && \
   cd .. && rm -f VBF-0.3.4.tar.gz
ENV VBFSYS ${EVNDISP}/vbf/
ENV PATH ${VBFSYS}/bin:${PATH}
ENV LD_LIBRARY_PATH "${VBFSYS}/lib:${LD_LIBRARY_PATH}"
#
## Install Eventdisplay
ARG GITUSER
ARG GITPW
ENV EVNDISPSYS ${EVNDISP}/EventDisplay_v4
RUN git clone https://$GITUSER:$GITPW@github.com/VERITAS-Observatory/EventDisplay_v4.git && \
    cd ${EVNDISPSYS} && \
    make -j 4 evndisp && \
    cp -r ./obj/*.pcm ./bin/

ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc

## Install Eventdisplay Analysis files
ENV OBS_EVNDISP_AUX_DIR ${EVNDISP}/Eventdisplay_AnalysisFiles_VTS
ENV OBS_USER_DATA_DIR /tmp/
RUN git clone https://$GITUSER:$GITPW@github.com/VERITAS-Observatory/Eventdisplay_AnalysisFiles_VTS.git
RUN git clone https://$GITUSER:$GITPW@github.com/VERITAS-Observatory/Eventdisplay_AnalysisScripts_VTS.git

