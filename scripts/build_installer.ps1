# Builds the Quill Radio installer from a QUILL Windows portable bundle.
#
# Usage:
#   .\scripts\build_installer.ps1 [-QuillRepo S:\QUILL] [-PayloadDir <dir>] [-Iscc <path>]
#
# The payload is the portable bundle the main repo's
# scripts/build_windows_distribution.py produces (embedded Python runtime
# flattened at the root, quill in Lib\site-packages). When -PayloadDir is not
# given, <QuillRepo>\windows-distribution\portable and <QuillRepo>\portable
# are tried in that order.

param(
    [string]$QuillRepo = "S:\QUILL",
    [string]$PayloadDir = "",
    [string]$Iscc = "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot

if (-not $PayloadDir) {
    foreach ($candidate in @(
        (Join-Path $QuillRepo "windows-distribution\portable"),
        (Join-Path $QuillRepo "portable")
    )) {
        if (Test-Path (Join-Path $candidate "Lib\site-packages\quill")) {
            $PayloadDir = $candidate
            break
        }
    }
}
if (-not $PayloadDir -or -not (Test-Path $PayloadDir)) {
    throw "No portable payload found. Build one in the QUILL repo first: python scripts\build_windows_distribution.py --bundle-python-dir <embedded-python>"
}
if (-not (Test-Path $Iscc)) {
    $fallback = "$env:ProgramFiles(x86)\Inno Setup 6\ISCC.exe"
    if (Test-Path $fallback) { $Iscc = $fallback } else { throw "ISCC.exe not found: $Iscc" }
}

Write-Host "Payload: $PayloadDir"
& $Iscc (Join-Path $repoRoot "installer\quill-radio.iss") `
    "/DPayloadDir=$PayloadDir" `
    "/O$(Join-Path $repoRoot 'dist')"
if ($LASTEXITCODE -ne 0) { throw "ISCC failed with exit code $LASTEXITCODE" }
Write-Host "Installer written to $(Join-Path $repoRoot 'dist')"
