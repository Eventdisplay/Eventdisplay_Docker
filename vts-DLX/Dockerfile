From rootproject/root:6.22.02-ubuntu20.04

# force ubunto to use bash for /bin/sh
# (otherwise trouble with many evndisp scripts)
RUN yes no | dpkg-reconfigure dash

## Basic packages
RUN apt-get update && apt-get install -y \
   git \
   tree \
   vim
RUN apt-get clean
#
## Introduce user evndisp - stop being root
ARG username=evndisp
RUN useradd --create-home --home-dir /home/${username} ${username}
USER ${username}
WORKDIR /home/${username}
ENV EVNDISP /home/${username}

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
ENV VERITAS_EVNDISP_AUX_DIR ${EVNDISP}/Eventdisplay_AnalysisFiles_VTS
RUN git clone https://$GITUSER:$GITPW@github.com/VERITAS-Observatory/Eventdisplay_AnalysisFiles_VTS.git
RUN git clone https://$GITUSER:$GITPW@github.com/VERITAS-Observatory/Eventdisplay_AnalysisScripts_VTS.git

ENV OBS_USER_DATA_DIR /data/
ENV VERITAS_USER_DATA_DIR /data/

