if (Test-Path llvm-win81-x64)
{
    Remove-Item -Recurse -Force llvm-win81-x64
}

if (-not (Test-Path llvm-src))
{
    ./ci/llvm-src.ps1
}

New-Item -ItemType Directory -Path llvm-win81-x64
Push-Location llvm-win81-x64

& cmake `
  -G"MinGW Makefiles" `
  -DCMAKE_SH="CMAKE_SH-NOTFOUND" `
  -DCMAKE_BUILD_TYPE=MinSizeRel `
  -DLLVM_INCLUDE_TESTS=OFF `
  -DLLVM_INCLUDE_BENCHMARKS=OFF `
  -DLLVM_INCLUDE_TOOLS=OFF `
  -DLLVM_OPTIMIZED_TABLEGEN=ON `
  ../llvm-src
& cmake --build .

ls lib

Pop-Location

$srcDir = "$(pwd)/llvm-src"
$buildDir = "$(pwd)/llvm-win81-x64"

Push-Location ci/win81-x64

# ./build.bat $srcDir $buildDir
# cp Release/libLLVM.dll $buildDir/MinSizeRel/lib/LLVM.dll

Pop-Location
