# Building `libLLVM` on OSX

Clone the `llvm` project:

```shell
$ git clone -b release_60 https://github.com/llvm-mirror/llvm
```

Configure LLVM to build as a single static binary:

```shell
$ mkdir llvm-build
$ cd llvm-build
$ cmake -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_LINK_LLVM_DYLIB=ON -DBUILD_SHARED_LIBS=OFF ../llvm
```

Build LLVM:

 ```
$ make
```

If everything goes well, you should find `llvm-build/lib/libLLVM.dylib`.
