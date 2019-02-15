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

& cmake -G"Visual Studio 15 2017" -Thost=x64 -DLLVM_OPTIMIZED_TABLEGEN=ON ../llvm-src
& cmake --build .

Pop-Location
