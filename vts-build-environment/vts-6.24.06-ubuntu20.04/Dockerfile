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
