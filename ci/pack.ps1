if (Test-Path llvm-pkg)
{
    Remove-Item -Recurse -Force llvm-pkg
}
New-Item -ItemType Directory -Path llvm-pkg

$ts = [math]::Round((get-date).ticks / 10000000)

& dotnet restore
& dotnet pack --no-build --version-suffix "dev-$ts"

cp "bin/Debug/libLLVM.6.0.0-dev-$ts.nupkg" llvm-pkg
