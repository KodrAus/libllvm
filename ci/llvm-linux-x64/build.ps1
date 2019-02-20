if (-not (Test-Path llvm-src))
{
    ./ci/llvm-src.ps1
}

if (Test-Path llvm-linux-x64)
{
    Remove-Item -Recurse -Force llvm-linux-x64
}
New-Item -ItemType Directory -Path llvm-linux-x64

Push-Location llvm-linux-x64

& cmake `
  -DCMAKE_BUILD_TYPE=MinSizeRel `
  -DLLVM_INCLUDE_TESTS=OFF `
  -DLLVM_INCLUDE_BENCHMARKS=OFF `
  -DLLVM_OPTIMIZED_TABLEGEN=ON `
  -DLLVM_LINK_LLVM_DYLIB=ON `
  ../llvm-src
& make

cp lib/libLLVM-6.0.so libLLVM.so

Pop-Location
