From ubuntu:20.04
From ubuntu:16.04

LABEL maintainer.name="Eventdisplay Team"

# All software is installed here
WORKDIR evndisp
ENV EVNDISP /evndisp

# Basic packages
RUN apt-get update && apt-get install -y \
  bash \
  bzip2 \
  git \
  vim \
  wget

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.12-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p ${EVNDISP}/conda && \
    rm ~/miniconda.sh && \
    ${EVNDISP}/conda/bin/conda clean -tipsy
ENV PATH /${EVNDISP}/conda/bin:$PATH

## RUN conda activate V2DL3_testing
RUN conda update -n base -c defaults conda && \
    conda update --all

ARG GITUSER
ARG GITPW

## Install v2dl3
RUN git clone https://$GITUSER:$GITPW@github.com/VERITAS-Observatory/V2DL3.git
RUN cd V2DL3 && \
    sed -i "s/v2dl3/base/" environment.yml && \
    conda env update --file  environment.yml

RUN cd V2DL3 && \
    pip install .
