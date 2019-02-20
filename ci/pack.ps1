if (Test-Path llvm-pkg)
{
    Remove-Item -Recurse -Force llvm-pkg
}
New-Item -ItemType Directory -Path llvm-pkg

$version = "6.0.0-dev-$([math]::Round((get-date).ticks / 10000000))"

& dotnet restore
& dotnet pack --no-build /p:Version=$version

cp "bin/Debug/libLLVM.$version.nupkg" llvm-pkg
