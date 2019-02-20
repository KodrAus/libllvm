if (Test-Path llvm-src)
{
    Remove-Item -Recurse -Force llvm-src
}

New-Item -ItemType Directory -Path llvm-src
Push-Location llvm-src

& git init
& git remote add origin https://github.com/llvm-mirror/llvm.git

if (Test-Path ../llvm-commit)
{
    Write-Host "Checking out specific commit"

    & git fetch origin $(Get-Content ../llvm-commit) --depth 1
}
else
{
    Write-Host "Checking out latest commit"

    & git fetch origin release_60 --depth 1

    New-Item -ItemType File -Path ../llvm-commit
    (& git rev-parse origin/release_60) | Add-Content -Path ../llvm-commit
}

& git checkout FETCH_HEAD

$major = (Select-String -Pattern "set\(LLVM_VERSION_MAJOR ([0-9]*)\)" -Path CMakeLists.txt).Matches.Groups[1].Value
$minor = (Select-String -Pattern "set\(LLVM_VERSION_MINOR ([0-9]*)\)" -Path CMakeLists.txt).Matches.Groups[1].Value
$patch = (Select-String -Pattern "set\(LLVM_VERSION_PATCH ([0-9]*)\)" -Path CMakeLists.txt).Matches.Groups[1].Value

if (Test-Path ../llvm-version)
{
    Remove-Item ../llvm-version
}
New-Item -ItemType File -Path ../llvm-version
Add-Content -Value "$major.$minor.$patch" -Path ../llvm-version

Pop-Location