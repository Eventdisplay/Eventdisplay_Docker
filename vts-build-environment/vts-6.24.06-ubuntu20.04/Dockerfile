From rootproject/root:6.24.06-ubuntu20.04

LABEL maintainer.name="Eventdisplay Team"
LABEL maintainer.email="gernot.maier@desy.de"

COPY VBF-0.3.4.tar.gz VBF-0.3.4.tar.gz
RUN tar -xzf VBF-0.3.4.tar.gz \
    && cd VBF-0.3.4 \
    && ./configure --prefix=/VBF \
    && make && make install \
    && make clean \
    && rm -f /VBF-0.3.4.tar.gz

ENV VBFSYS /VBF
ENV LD_LIBRARY_PATH "${VBFSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${VBFSYS}/bin:${PATH}

COPY EventDisplay_v4-487e.tar.gz EventDisplay_v4-487e.tar.gz
RUN mkdir -p /Eventdisplay/
ENV EVNDISPSYS /Eventdisplay
ENV LD_LIBRARY_PATH "${EVNDISPSYS}/lib:${ROOTSYS}/lib:${VBFSYS}/lib:${LD_LIBRARY_PATH}"

RUN tar -xzf EventDisplay_v4-487e.tar.gz -C /Eventdisplay/ \
    && rm -f EventDisplay_v4-487e.tar.gz \
    && cd /Eventdisplay/ && mv EventDisplay_v4-487e/* . \
    && sed -i "s/c++11/c++14/" Makefile \
    && make VTS

ENV EVNDISPSCRIPTS /data/EVNDISPSCRIPTS
ENV VERITAS_EVNDISP_AUX_DIR /data/VERITAS_EVNDISP_AUX_DIR
ENV VERITAS_DATA_DIR /data/data
ENV VERITAS_USER_DATA_DIR /data/output
