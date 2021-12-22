From ubuntu:20.04

LABEL maintainer.name="Eventdisplay Team"

ENV WORKDIR /workdir
WORKDIR ${WORKDIR}

RUN apt-get update && apt-get install -y \
    bash \
    bzip2 \
    gcc \
    g++ \
    git \
    libblas-dev \
    libfreetype6 \
    libxpm4 \
    libxtst6 \
    vim \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install ROOT
RUN wget https://root.cern/download/root_v6.24.06.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    tar -xzf root_v6.24.06.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    rm -f root_v6.24.06.Linux-ubuntu20-x86_64-gcc9.3.tar.gz && \
    echo /opt/root/lib >> /etc/ld.so.conf && \
    ldconfig

ENV ROOTSYS ${WORKDIR}/root
ENV LD_LIBRARY_PATH "${ROOTSYS}/lib/:${LD_LIBRARY_PATH}"
ENV PATH ${ROOTSYS}/bin:${PATH}

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p ${WORKDIR}/conda && \
    rm ~/miniconda.sh && \
    ${WORKDIR}/conda/bin/conda clean -tipsy
ENV PATH /${WORKDIR}/conda/bin:$PATH

# requires github user name and password (private repository)
ARG GITUSER
ARG GITPW
RUN git clone https://$GITUSER:$GITPW@github.com/VERITAS-Observatory/V2DL3.git
RUN cd V2DL3 && \
    sed -i "s/v2dl3/base/" environment.yml && \
    grep -v gammapy environment.yml | grep -v root | grep -v ipywidgets > environment.yml.tmp && \
    mv -f environment.yml.tmp environment.yml && \
    echo "  - scipy" >> environment.yml && \
    conda env update --file  environment.yml && \
    conda clean --all

RUN cd V2DL3 && \
    pip install .

COPY run.sh /workdir/

RUN echo "source /workdir/root/bin/thisroot.sh" >> /etc/bash.bashrc
ENTRYPOINT /bin/bash
