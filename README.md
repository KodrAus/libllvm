# `libLLVM` [![Build Status](https://dev.azure.com/kodraus/libllvm/_apis/build/status/KodrAus.libllvm?branchName=master)](https://dev.azure.com/kodraus/libllvm/_build/latest?definitionId=1&branchName=master)

Continuous builds of [LLVM](http://llvm.org/) for various platforms, packaged for consumption in .NET.

## Supported LLVM versions

- `6.0.x` (based on the `release_60` branch)

## Supported platforms

- Linux x64
- OSX x64
- Windows x64

## Adding `libLLVM` to your .NET project

Builds from the `master` branch are published as a cross-platform NuGet package on [`feedz.io`](https://feedz.io/).

Add the `feedz.io` NuGet feed to a [`nuget.conf` file](https://docs.microsoft.com/en-us/nuget/reference/nuget-config-file) in your project:

```xml
<add key="libllvm.feedz.io" value="https://f.feedz.io/kodraus/libllvm/nuget" />
```

Add `libLLVM` as a [package reference to your `csproj`](https://docs.microsoft.com/en-us/nuget/consume-packages/package-references-in-project-files):

```xml
<PackageReference Include="libLLVM" Version="6.0.0-*" />
```

## Building locally

A local platform-specific package can be made by calling `build.ps1`. The resulting `llvm-pkg` folder can be used as a local NuGet feed.

Local builds require .NET Core, PowerShell, cmake, and a native toolchain (MSVC on Windows, Clang on OSX, GCC on Linux).
