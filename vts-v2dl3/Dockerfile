# Ubuntu based image
From ubuntu:20.04

LABEL maintainer.name="Eventdisplay Team"

# All software is installed here
WORKDIR evndisp
ENV EVNDISP /evndisp

# Basic packages
RUN apt-get update && apt-get install -y \
  bash \
  bzip2 \
  gcc \
  g++ \
  git \
  make \
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
    conda update --all && \
	conda install -c conda-forge root && \
	conda install -c conda-forge uproot && \
	conda install -c conda-forge matplotlib seaborn scipy root_numpy numpy astropy cython pkgconfig nb_conda_kernels && \
	/bin/bash -c "conda env list"

## Install Eventdisplay
ARG GITUSER
ARG GITPW
ENV EVNDISPSYS ${EVNDISP}/EventDisplay_v4
RUN git clone https://$GITUSER:$GITPW@github.com/VERITAS-Observatory/EventDisplay_v4.git && \
    cd ${EVNDISPSYS} && \
	sed -i 's/-std=c++11/-std=c++17/g' Makefile && \
    make -j 4 anasum slib
ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc

## Install v2dl3
RUN git clone https://$GITUSER:$GITPW@github.com/tobiaskleiner/V2DL3
RUN cd V2DL3 && \
    pip install .

## Configuring access to Jupyter
RUN mkdir /${EVNDISP}/notebooks
RUN jupyter notebook --generate-config --allow-root

#RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/${username}/.jupyter/jupyter_notebook_config.py
#
## Jupyter listens port: 8888
#EXPOSE 8888
#
## Run Jupyter notebook as Docker main process
#CMD ["jupyter", "notebook", "--allow-root", "--ip='*'", "--port=8888"]
