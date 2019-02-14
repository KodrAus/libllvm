#!/bin/bash

set -e

if [ -d llvm-src ]; then rm -r llvm-src; fi

mkdir llvm-src
pushd llvm-src

git init
git remote add origin https://github.com/llvm-mirror/llvm.git

if [ -f ../llvm-commit ]; then
    echo "Checking out specific commit"

    git fetch origin $(cat ../llvm-commit) --depth 1
else
    echo "Checking out latest commit"
    
    git fetch origin release_60 --depth 1
    echo $(git rev-parse origin/release_60) > ../llvm-commit
fi

git checkout FETCH_HEAD

popd
