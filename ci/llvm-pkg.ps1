if (Test-Path llvm-pkg)
{
    Remove-Item -Recurse -Force llvm-pkg
}
New-Item -ItemType Directory -Path llvm-pkg

$prefix = "0.0.0"
if (Test-Path llvm-version)
{
    $prefix = cat llvm-version
}

$version = "$prefix-dev-$([math]::Round((get-date).ticks / 10000000))"

& dotnet restore
& dotnet pack --no-build /p:Version=$version

cp "bin/Debug/libLLVM.$version.nupkg" llvm-pkg
