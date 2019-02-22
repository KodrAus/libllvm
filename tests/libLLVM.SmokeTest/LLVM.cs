using System;
using System.Runtime.InteropServices;

namespace libLLVM.SmokeTest
{
    static class LLVM
    {
        [DllImport("LLVM", EntryPoint = "LLVMModuleCreateWithName", CallingConvention = CallingConvention.Cdecl)]
        public static extern IntPtr ModuleCreateWithName([MarshalAs(UnmanagedType.LPStr)] string moduleId);

        [DllImport("LLVM", EntryPoint = "LLVMDisposeModule", CallingConvention = CallingConvention.Cdecl)]
        public static extern void DisposeModule(IntPtr module);
    }
}
