#! /bin/sh
pip install -U torch torchvision cython
pip install -U 'git+https://github.com/facebookresearch/fvcore.git' 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'
git clone https://github.com/facebookresearch/detectron2 detectron2_repo
pip install -e detectron2_repo
# You can find more details at https://github.com/facebookresearch/detectron2/blob/master/INSTALL.md
