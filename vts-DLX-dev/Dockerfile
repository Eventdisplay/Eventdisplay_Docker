From rootproject/root:latest

# force ubunto to use bash for /bin/sh
# (otherwise trouble with many evndisp scripts)
RUN yes no | dpkg-reconfigure dash

## Basic packages
RUN apt-get update && apt-get install -y \
   git \
   vim
RUN apt-get clean
WORKDIR /data/
ENV EVNDISP /data/

## Install VBF
RUN mkdir ${WORKDIR}/vbf/
COPY VBF-0.3.4.tar.gz .
RUN tar -xvzf VBF-0.3.4.tar.gz && \
   cd VBF-0.3.4  && \
   ./configure --prefix=${WORKDIR}/vbf && \
   make && make install && \
   cd .. && rm -f VBF-0.3.4.tar.gz
ENV VBFSYS ${WORKDIR}/vbf/
ENV PATH ${VBFSYS}/bin:${PATH}
ENV LD_LIBRARY_PATH "${VBFSYS}/lib:${LD_LIBRARY_PATH}"
#
## Install Eventdisplay
ENV EVNDISPSYS ${EVNDISP}/EventDisplay_v4
ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc
