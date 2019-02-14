#!/bin/bash

set -e

if [ -d osx-x64-src ]; then rm -r osx-x64-src; fi
if [ -d osx-x64 ]; then rm -r osx-x64; fi

git clone -b release_60 --depth 1 https://github.com/llvm-mirror/llvm.git osx-x64-src

mkdir osx-x64
pushd osx-x64

# cmake -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_LINK_LLVM_DYLIB=ON -DBUILD_SHARED_LIBS=OFF ../osx-x64-src
# make
mkdir lib
touch lib/libLLVM.dylib

ls lib

popd
