set builddir=%1

set vcvars="C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

if exist %vcvars% (
    @call %vcvars%
)

cmake --build %builddir% --config MinSizeRel

lib /OUT:%builddir%\MinSizeRel\lib\LLVM.lib %builddir%\MinSizeRel\lib\LLVM*.lib
dumpbin /linkermember:1 %builddir%\MinSizeRel\lib\LLVM.lib > raw-exports
