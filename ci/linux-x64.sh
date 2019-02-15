#!/bin/bash

set -e

if [ -d llvm-linux-x64 ]; then rm -r llvm-linux-x64; fi

if [ ! -d llvm-src ]; then ./ci/llvm-src.sh; fi

mkdir llvm-linux-x64
pushd llvm-linux-x64

cmake \
  -DCMAKE_BUILD_TYPE=MinSizeRel \
  -DLLVM_INCLUDE_TESTS=OFF \
  -DLLVM_INCLUDE_BENCHMARKS=OFF \
  -DLLVM_OPTIMIZED_TABLEGEN=ON \
  -DLLVM_LINK_LLVM_DYLIB=ON \
  ../llvm-src
make

cp lib/libLLVM-6.0.so lib/libLLVM.so

ls lib

popd
