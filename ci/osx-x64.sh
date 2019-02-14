#!/bin/bash

set -e

if [ -d llvm-osx-x64 ]; then rm -r llvm-osx-x64; fi

if [ ! -d llvm-src ]; then
    ./ci/llvm-src.sh
fi

mkdir llvm-osx-x64
pushd llvm-osx-x64

cmake -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_LINK_LLVM_DYLIB=ON -DBUILD_SHARED_LIBS=OFF ../llvm-src
make

popd
