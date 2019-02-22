using System;
using Xunit;

namespace libLLVM.SmokeTest
{
    public class ItWorks
    {
        [Fact]
        public void CanCreateAndDisposeModule()
        {
            var module = LLVM.ModuleCreateWithName("mymodule");
            Assert.NotEqual(module, IntPtr.Zero);

            LLVM.DisposeModule(module);
        }
    }
}
