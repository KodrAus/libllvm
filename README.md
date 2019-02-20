# `libLLVM` [![Build Status](https://dev.azure.com/kodraus/libllvm/_apis/build/status/KodrAus.libllvm?branchName=master)](https://dev.azure.com/kodraus/libllvm/_build/latest?definitionId=1&branchName=master)

Continuous builds of [LLVM](http://llvm.org/) for various platforms, packaged for consumption in .NET.

Build artifacts are published in [Azure Pipelines](https://dev.azure.com/kodraus/libllvm/_build/latest?definitionId=1&branchName=master).

## Supported LLVM versions

- `6.0.x` (based on the `release_60` branch)

## Supported platforms

- Linux x64
- OSX x64
- Windows x64

## Building locally

A local platform-specific package can be made by calling `build.ps1`. The resulting `llvm-pkg` folder can be used as a local NuGet feed.

Local builds require .NET Core, PowerShell, cmake, and a native toolchain (MSVC on Windows, Clang on OSX, GCC on Linux).
