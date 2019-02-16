if (Test-Path llvm-win81-x64)
{
    Remove-Item -Recurse -Force llvm-win81-x64
}

if (-not (Test-Path llvm-win81-x64))
{
    ./ci/llvm-src.ps1
}

New-Item -ItemType Directory -Path llvm-win81-x64
Push-Location llvm-win81-x64

& cmake `
  -G"Visual Studio 15 2017" `
  -DLLVM_INCLUDE_TESTS=OFF `
  -DLLVM_INCLUDE_BENCHMARKS=OFF `
  -DLLVM_INCLUDE_TOOLS=OFF `
  -DLLVM_OPTIMIZED_TABLEGEN=ON `
  ../llvm-src
& cmake --build . --config MinSizeRel

ls MinSizeRel/lib

Pop-Location

$env:LLVM_SRC_DIR = "$(pwd)/llvm-src"
$env:LLVM_BUILD_DIR = "$(pwd)/win81-x64"

Push-Location ci/win81-x64

./build.bat

cp Release/LLVM.dll $buildDir/MinSizeRel/lib

Pop-Location