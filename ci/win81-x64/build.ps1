if (-not (Test-Path llvm-src))
{
    ./ci/llvm-src.ps1
}

if (Test-Path llvm-win81-x64)
{
    Remove-Item -Recurse -Force llvm-win81-x64
}
New-Item -ItemType Directory -Path llvm-win81-x64

Push-Location llvm-win81-x64

& cmake `
  -G"Visual Studio 15 2017 Win64" `
  -Thost=x64 `
  -DLLVM_INCLUDE_TESTS=OFF `
  -DLLVM_INCLUDE_BENCHMARKS=OFF `
  -DLLVM_INCLUDE_TOOLS=OFF `
  -DLLVM_OPTIMIZED_TABLEGEN=ON `
  ../llvm-src

Pop-Location

$srcDir = "$(pwd)/llvm-src"
$buildDir = "$(pwd)/llvm-win81-x64"

Push-Location ci/win81-x64

./build.bat $buildDir
./assemble.bat $srcDir $buildDir

cp x64/MinSizeRel/libLLVM.dll $buildDir/LLVM.dll

Pop-Location
