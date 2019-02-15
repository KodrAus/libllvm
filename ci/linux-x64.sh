#!/bin/bash

set -e

if [ -d llvm-linux-x64 ]; then rm -r llvm-linux-x64; fi

if [ ! -d llvm-src ]; then ./ci/llvm-src.sh; fi

mkdir llvm-linux-x64
pushd llvm-linux-x64

cmake \
  -DLLVM_INCLUDE_TESTS=OFF \
  -DLLVM_INCLUDE_BENCHMARKS=OFF \
  -DLLVM_INCLUDE_TOOLS=OFF \
  -DLLVM_OPTIMIZED_TABLEGEN=ON \
  -DLLVM_LINK_LLVM_DYLIB=ON \
  -DBUILD_SHARED_LIBS=OFF \
  ../llvm-src
make

popd
