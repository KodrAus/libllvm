set srcdir=%1
set builddir=%2

set vcvarsall="C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"

if exist %vcvarsall% (
    @call %vcvarsall% amd64_x64
)

msbuild /p:Configuration=Release /p:Platform=x64 /p:LLVM_SRC_DIR=%srcdir% /p:LLVM_BUILD_DIR=%builddir% libLLVM.vcxproj
