#!/bin/bash

echo "##########################################################"
echo "Adjusting it to run on cuda8 and cudnn5.1"
cp Makefile.config.debiancuda8 caffe-fast-rcnn/Makefile.config
cd caffe-fast-rcnn  
git remote add caffe https://github.com/BVLC/caffe.git  
git fetch caffe  
git merge -X theirs caffe/master  

echo "##########################################################"
echo "Compiling caffe-fast-rcnn"
sed -i '/static_cast/d' include/caffe/layers/python_layer.hpp
make all -j8
make pycaffe

echo "##########################################################"
echo "Compiling lib/"
cd ../lib
make
