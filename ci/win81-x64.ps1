Push-Location ci/win81-x64
Invoke-WebRequest -Uri "https://download.visualstudio.microsoft.com/download/pr/f8db94a7-42dc-4413-b987-b21dcb0b1661/5e24cf2c187f46bde25c5515250fa9a0/vs_buildtools.exe" -OutFile vs_buildtools.exe
./vs_buildtools.exe install --quiet --wait --norestart

ls "C:\Program Files (x86)\Microsoft Visual Studio\2017"
./build.bat
Pop-Location

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

$srcDir = "$(pwd)/llvm-src"
$buildDir = "$(pwd)/win81-x64"

Push-Location ci/win81-x64

./build.bat

cp Release/LLVM.dll $buildDir/MinSizeRel/lib

Pop-Location