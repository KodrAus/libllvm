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

    touch ../llvm-commit
    echo -n $(git rev-parse origin/release_60) >> ../llvm-commit
fi

git checkout FETCH_HEAD

if [ -f ../llvm-version ]; then rm ../llvm-version; fi

content=$(cat CMakeLists.txt)

major_regex="set\(LLVM_VERSION_MAJOR ([0-9]*)\)"
major=0
if [[ $content =~ $major_regex ]]; then major=${BASH_REMATCH[1]}; fi

minor_regex="set\(LLVM_VERSION_MINOR ([0-9]*)\)"
minor=0
if [[ $content =~ $minor_regex ]]; then minor=${BASH_REMATCH[1]}; fi

patch_regex="set\(LLVM_VERSION_PATCH ([0-9]*)\)"
patch=0
if [[ $content =~ $patch_regex ]]; then patch=${BASH_REMATCH[1]}; fi

touch ../llvm-version
echo -n "$major.$minor.$patch" >> ../llvm-version