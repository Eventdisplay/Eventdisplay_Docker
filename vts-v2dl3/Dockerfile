#specify git username and password for ED and V2DL3 repository download (line 60 and 71)
#also specify number of cores for make VTS compilation (j-flag)
# Ubuntu based image
FROM ubuntu:20.04

LABEL maintainer.name="Eventdisplay Team"

# force ubunto to use bash for /bin/sh
# (otherwise trouble with many evndisp scripts)
RUN yes no | dpkg-reconfigure dash

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade

RUN apt-get update && apt-get install -y \
  bash \
  bzip2 \
  emacs \
  gcc \
  g++ \
  git \
  make \
  wget 
RUN apt-get clean

# Add sudo
RUN apt-get -y install sudo

# Add user ${username} with no password, add to sudo group
ARG username=v2dl3user
RUN adduser --disabled-password --gecos '' ${username}
RUN adduser ${username} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${username}
WORKDIR /home/${username}/
RUN chmod a+rwx /home/${username}/

# Install miniconda to /miniconda

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.12-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /home/${username}/conda && \
    rm ~/miniconda.sh && \
    /home/${username}/conda/bin/conda clean -tipsy && \
    #ln -s /home/${username}/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
ENV PATH /home/${username}/conda/bin:$PATH

RUN conda update conda
RUN conda update --all

# RUN conda activate V2DL3_testing
RUN /bin/bash -c "conda env list" && \
	/bin/bash -c "source activate base" && \
	conda install -c conda-forge root && \
	conda install -c conda-forge uproot && \
	conda install -c conda-forge matplotlib seaborn scipy root_numpy numpy astropy cython pkgconfig nb_conda_kernels && \
	/bin/bash -c "conda env list"

# Install Eventdisplay
ENV EVNDISP /home/${username}
ENV EVNDISPSYS ${EVNDISP}/EventDisplay_v4/
RUN git clone https://username:password@github.com/VERITAS-Observatory/EventDisplay_v4/
RUN /bin/bash -c "source activate base" && \ 
	cd ${EVNDISPSYS} && \
	sed -i 's/-std=c++11/-std=c++17/g' Makefile && \
	/bin/bash -c "source ./setObservatory.sh VTS" && \
    make configuration && \
    make VTS -w -j24
    
ENV LD_LIBRARY_PATH "${EVNDISPSYS}/obj:${LD_LIBRARY_PATH}"
ENV ROOT_INCLUDE_PATH ${EVNDISPSYS}/inc

RUN git clone https://username:password@github.com/tobiaskleiner/V2DL3
# Install v2dl3
RUN cd V2DL3 && \
	/bin/bash -c "source activate base" && \
	pip install .


# Configuring access to Jupyter
RUN mkdir /home/${username}/notebooks
RUN jupyter notebook --generate-config --allow-root

#RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/${username}/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupyter notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--ip='*'", "--port=8888"]
