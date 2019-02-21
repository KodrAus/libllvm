if (-not (Test-Path llvm-pkg))
{
    New-Item -ItemType Directory -Path llvm-pkg
}

$buildMeta = ""
if (Test-Path llvm-version)
{
    $buildMeta = "+$(Get-Content -Path llvm-version)"
}

$prefix = (Select-String -Pattern "Version>([0-9]*\.[0-9]*\.[0-9]*)</Version" -Path libLLVM.csproj).Matches.Groups[1].Value
$ts = [math]::Round(((get-date).ToUniversalTime()).ticks / 10000000)

$version = "$prefix-dev.$ts"

$packOSXx64 = Test-Path llvm-osx-x64
$packWin81x64 = Test-Path llvm-win81-x64
$packLinuxx64 = Test-Path llvm-linux-x64

& dotnet restore
& dotnet pack `
    --no-build `
    /p:Version="$($version)$buildMeta" `
    /p:Pack-OSX-x64=$packOSXx64 `
    /p:Pack-Win81-x64=$packWin81x64 `
    /p:Pack-Linux-x64=$packLinuxx64

cp "bin/Debug/libLLVM.$version.nupkg" llvm-pkg
