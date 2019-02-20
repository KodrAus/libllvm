if (Test-Path llvm-pkg)
{
    Remove-Item -Recurse -Force llvm-pkg
}
New-Item -ItemType Directory -Path llvm-pkg

$buildMeta = ""
if (Test-Path llvm-version)
{
    $buildMeta = "+$(Get-Content -Path llvm-version)"
}

$prefix = (Select-String -Pattern "Version>([0-9]*\.[0-9]*\.[0-9]*)</Version" -Path libLLVM.csproj).Matches.Groups[1].Value
$ts = [math]::Round((get-date).ticks / 10000000)

$version = "$prefix-dev.$ts"

& dotnet restore
& dotnet pack --no-build /p:Version="$($version)$buildMeta"

cp "bin/Debug/libLLVM.$version.nupkg" llvm-pkg
