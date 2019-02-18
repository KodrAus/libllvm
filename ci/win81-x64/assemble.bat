set srcdir=%1
set builddir=%2

set vcvars="C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

if exist %vcvars% (
    @call %vcvars%
)

msbuild /p:Configuration=Release /p:Platform=x64 /p:LLVM_SRC_DIR=%srcdir% /p:LLVM_BUILD_DIR=%builddir% libLLVM.vcxproj
