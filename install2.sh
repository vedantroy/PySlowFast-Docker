#! /bin/sh
pip install git+https://github.com/facebookresearch/pytorchvideo.git@98a0e3345439d7c0c2c2894611ed1029b2f6114b
micromamba install av -c conda-forge
pip install -U iopath
# Avoids ImportError: libGL.so.1: cannot open shared object file: No such file or directory
pip install simplejson psutil opencv-python-headless
