FROM rootproject/root:latest AS vbf_build

LABEL maintainer.name="Eventdisplay Team"
LABEL maintainer.email="gernot.maier@desy.de"


COPY VBF-0.3.4-c17.tar.gz VBF-0.3.4-c17.tar.gz
RUN tar -xzf VBF-0.3.4-c17.tar.gz \
    && cd VBF-0.3.4-c17 \
    && ./configure --prefix=/opt/VBF \
    && make && make install \
    && make clean \
    && rm -f /VBF-0.3.4-C17.tar.gz

FROM rootproject/root:latest as eventdisplay_build
ARG EVNDISPVERSION="490-dev-v0.7"
WORKDIR /opt/
COPY --from=vbf_build /opt/VBF /opt/VBF
ENV VBFSYS /opt/VBF
ENV LD_LIBRARY_PATH "${VBFSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${VBFSYS}/bin:${PATH}

COPY EventDisplay_v4-${EVNDISPVERSION}.tar.gz EventDisplay_v4-${EVNDISPVERSION}.tar.gz
ENV EVNDISPSYS /opt/Eventdisplay
ENV LD_LIBRARY_PATH "${EVNDISPSYS}/lib:${ROOTSYS}/lib:${VBFSYS}/lib:${LD_LIBRARY_PATH}"
ENV SOFASYS "${EVNDISPSYS}/sofa"

 RUN tar -xzf EventDisplay_v4-${EVNDISPVERSION}.tar.gz \
     && mv EventDisplay_v4-${EVNDISPVERSION} /opt/Eventdisplay \
     && cd ${EVNDISPSYS} && ./install_sofa.sh \
     && make VTS

FROM rootproject/root:latest
WORKDIR /opt/
COPY --from=vbf_build /opt/VBF /opt/VBF
COPY --from=eventdisplay_build /opt/Eventdisplay /opt/Eventdisplay

ENV EVNDISPSYS /opt/Eventdisplay
ENV VBFSYS /opt/VBF
ENV LD_LIBRARY_PATH "${VBFSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${VBFSYS}/bin:${PATH}
ENV LD_LIBRARY_PATH "${EVNDISPSYS}/lib:${ROOTSYS}/lib:${VBFSYS}/lib:${LD_LIBRARY_PATH}"
ENV SOFASYS "${EVNDISPSYS}/sofa"
