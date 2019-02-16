set srcdir=%1
set builddir=%2

@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvars32.bat"
msbuild /p:Configuration=Release /p:Platform=Win32 /p:LLVM_SRC_DIR=%srcdir% /p:LLVM_BUILD_DIR=%builddir% libLLVM.vcxproj
