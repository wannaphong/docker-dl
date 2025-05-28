FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-devel

RUN ["/bin/bash", "-c", "echo I am using bash"]
SHELL ["/bin/bash", "-c"]
##############################################################################
# Temporary Installation Directory
##############################################################################
ENV STAGE_DIR=/tmp
RUN mkdir -p ${STAGE_DIR}

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
##############################################################################
# Installation/Basic Utilities
##############################################################################
# OPENMPI
##############################################################################
##############################################################################
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common build-essential autotools-dev \
    nfs-common pdsh \
    cmake g++ gcc \
    curl wget vim tmux emacs less unzip \
    htop iftop iotop ca-certificates openssh-client openssh-server \
    rsync iputils-ping net-tools sudo \
    llvm-11-dev \
                      bzip2 \
                      cmake \
                      cpio \
                      curl \
                      g++ \
                      gcc \
                      gfortran \
                      git \
                      gosu \
                      libblas-dev \
                      liblapack-dev \
                      libopenmpi-dev \
                      openmpi-bin \
                      python3-dev \
                      python3-pip \
                      virtualenv \
                      wget \
                      zlib1g-dev \
                      vim       \
                      htop      \
 && apt-get --yes -qq clean \
 && rm -rf /var/lib/apt/lists/*

##############################################################################
# Python
##############################################################################
ENV PYTHON_VERSION=3
RUN apt-get install -y python3 python3-dev && \
    rm -f /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py && \
    pip install --upgrade pip && \
    # Print python an pip version
    python -V && pip -V

##############################################################################
# Some Packages
##############################################################################
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libsndfile-dev \
        libcupti-dev \
        libjpeg-dev \
        libpng-dev \
        screen \
        libaio-dev \
        git
RUN pip install psutil \
        yappi \
        cffi \
        ipdb \
        pandas \
        matplotlib \
        py3nvml \
        pyarrow \
        graphviz \
        astor \
        boto3 \
        tqdm \
        sentencepiece \
        msgpack \
        requests \
        pandas \
        sphinx \
        sphinx_rtd_theme \
        scipy \
        scikit-learn \
        nvidia-ml-py3 \
        mpi4py \
        cupy-cuda11x \
        pyyaml \
        ipython \
        tensorboardX \
        trl \
        transformers \
        numpy \
        bitsandbytes \
        peft \
        flash-attn==2.7.4.post1 \
        deepspeed
WORKDIR /workspace
RUN echo I am using bash, which is now the default
ENV SHELL=/bin/bash
