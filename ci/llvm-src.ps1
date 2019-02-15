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
    (& git rev-parse origin/release_60) | Out-File -FilePath ../llvm-commit
}

& git checkout FETCH_HEAD

Pop-Location