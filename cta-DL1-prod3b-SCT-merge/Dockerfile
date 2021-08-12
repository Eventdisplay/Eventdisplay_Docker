From ubuntu:20.04

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

# Install hessioxx twice
# (for extraction and merging)
COPY hessioxxx.tar.gz .
# extraction
RUN tar -xvzf hessioxxx.tar.gz && \
   mv hessioxxx hessioxxx-extract && \
   cd hessioxxx-extract && \
   make EXTRA_DEFINES="-DCTA_PROD4 -DMAXIMUM_TELESCOPES=567" && \
   cd .. 

# merging
RUN tar -xvzf hessioxxx.tar.gz && \
   cd hessioxxx && \
   make EXTRA_DEFINES="-DCTA_PROD4_SC -DMAXIMUM_TELESCOPES=92" && \
   cd .. && rm -f hessioxxx.tar.gz
ENV HESSIOSYS ${WORKDIR}/hessioxxx
ENV LD_LIBRARY_PATH "${HESSIOSYS}/lib:${LD_LIBRARY_PATH}"

# Install ROOT
RUN wget https://root.cern/download/root_v6.22.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    tar -xzf root_v6.22.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    rm -f root_v6.22.02.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    echo /opt/root/lib >> /etc/ld.so.conf && \
    ldconfig
ENV ROOTSYS ${WORKDIR}/root
ENV LD_LIBRARY_PATH "${ROOTSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${ROOTSYS}/bin:${PATH}

# Layout files 
COPY CTA.prod3bS-M6C5a-14MSTs37SSTs-MSTF.lis .

# Run script
COPY run.sh .
