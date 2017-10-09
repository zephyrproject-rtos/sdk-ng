#!/bin/bash

target=${1}
wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.23.0.tar.bz2
tar xf crosstool-ng-1.23.0.tar.bz2


pushd crosstool-ng-1.23.0/
patch -p1 < ../patches/0001-iamcu-support-x86-iamcu-ABIs.patch
./configure
make && sudo make install
popd

mkdir -p build
cd build
export CT_PREFIX=`pwd`/output
mkdir -p ${CT_PREFIX}/sources
ct-ng clean
cp ../configs/${target}.config .config
ct-ng build
