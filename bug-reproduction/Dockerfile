# Build this with DOCKER_BUILDKIT=1 for caching
FROM nvidia/cuda:11.6.1-devel-ubuntu20.04

WORKDIR /app

# Prevents apt from giving prompts
# Set as ARG so it does not persist after build
# https://serverfault.com/questions/618994/when-building-from-dockerfile-debian-ubuntu-package-install-debconf-noninteract
ARG DEBIAN_FRONTEND=noninteractive
# Docker docs: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# In addition, when you clean up the apt cache by removing /var/lib/apt/lists it reduces the image size, since the apt cache is not stored in a layer.
# Since the RUN statement starts with apt-get update, the package cache is always refreshed prior to apt-get install.
RUN apt update && apt install \
	# for installing miniconda
	curl \
	-y && rm -rf /var/lib/apt/lists/*

# Install miniconda.sh
ENV PATH="/root/miniconda3/bin:${PATH}"
COPY ./environment.yml ./environment.yml
RUN curl \
	https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh -o miniconda.sh \
	&& mkdir /root/.conda \
	&& bash miniconda.sh -b \
	&& rm miniconda.sh

RUN conda env create -f environment.yml

RUN apt update && apt install \
	# for installing pyslowfast
	git \
	-y && rm -rf /var/lib/apt/lists/*

COPY ./install.sh ./install.sh
RUN --mount=type=cache,target=/root/.cache conda run --no-capture-output -n pyslowfast ./install.sh

COPY ./install2.sh ./install2.sh
RUN --mount=type=cache,target=/root/.cache conda run --no-capture-output -n pyslowfast ./install2.sh

COPY ./SlowFast ./SlowFast
ENV PYTHONPATH "${PYTHONPATH}:/app/SlowFast"
RUN cd SlowFast \
	&& conda run --no-capture-output -n pyslowfast python setup.py build develop