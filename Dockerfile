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
	# we need wget and tar with support for bzip2. 
	curl tar wget \
	-y && rm -rf /var/lib/apt/lists/*

# Install micromamba.sh
ENV PATH="/root/bin/:${PATH}"
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba \
	&& mkdir /root/bin \ 
	&& mv bin/micromamba /root/bin \
	&& rmdir bin

COPY ./environment.yml ./environment.yml
RUN micromamba create -f environment.yml

RUN apt update && apt install \
	# for installing pyslowfast
	git \
	-y && rm -rf /var/lib/apt/lists/*

COPY ./install.sh ./install.sh
RUN --mount=type=cache,target=/root/.cache micromamba run -n pyslowfast ./install.sh

COPY ./install2.sh ./install2.sh
RUN --mount=type=cache,target=/root/.cache micromamba run -n pyslowfast ./install2.sh

COPY ./SlowFastBuild ./SlowFast
ENV PYTHONPATH "${PYTHONPATH}:/app/SlowFast"
RUN --mount=type=cache,target=/root/.cache cd SlowFast \
	&& micromamba run -n pyslowfast python setup.py build develop
COPY ./run_cpu.sh ./run_cpu.sh
COPY ./run_gpu.sh ./run_gpu.sh