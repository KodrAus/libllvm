if (-not (Test-Path llvm-src))
{
    ./ci/llvm-src.ps1
}

if (Test-Path llvm-win-x64)
{
    Remove-Item -Recurse -Force llvm-win-x64
}
New-Item -ItemType Directory -Path llvm-win-x64

Push-Location llvm-win-x64

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
$buildDir = "$(pwd)/llvm-win-x64"

Push-Location ci/llvm-win-x64

if (Test-Path EXPORTS.def)
{
    Remove-Item EXPORTS.def
}

if (Test-Path raw-exports)
{
    Remove-Item raw-exports
}

./llvm-build.bat $buildDir

New-Item -ItemType File EXPORTS.def
Add-Content -Value "EXPORTS" -Path EXPORTS.def
(Select-String -Pattern "^\s+\w+\s+(LLVM.*)$" -Path raw-exports).Matches | foreach { Add-Content -Value $_.Groups[1].Value -Path EXPORTS.def }

./llvm-assemble.bat $srcDir $buildDir

cp x64/MinSizeRel/libLLVM.dll $buildDir/LLVM.dll

Pop-Location
