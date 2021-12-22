From scientificlinux/sl:7

LABEL maintainer.name="Eventdisplay Team"
LABEL maintainer.email="gernot.maier@desy.de"

COPY packages packages

RUN yum update -q -y \
    && yum install -y $(cat packages) \
    && rm -f /packages

ENV ROOTSYS /root
ENV LD_LIBRARY_PATH "${ROOTSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${ROOTSYS}/bin:${PATH}
COPY root_v5.34.38.source.tar.gz root_v5.34.38.source.tar.gz
RUN tar -xzf root_v5.34.38.source.tar.gz \
    && cd /root \
    && ./configure \
    && make -j 4 && make install \
    && ldconfig && make clean \
    && rm -f /root_v5.34.38.source.tar.gz

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
