# Build a local, non-portable libLLVM NuGet package

if ($IsMacOS) {
    ./ci/llvm-osx-x64/build.ps1
}

if ($IsLinux) {
    ./ci/llvm-linux-x64/build.ps1
}

if ($IsWindows) {
    ./ci/llvm-win81-x64/build.ps1
}

./ci/llvm-pkg.ps1
