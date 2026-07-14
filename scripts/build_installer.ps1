# Builds the Quill Radio installer from the PyInstaller one-file build.
#
# Usage:
#   .\scripts\build_installer.ps1 [-FfmpegDir <dir>] [-Iscc <path>] [-SkipExe]
#
# Runs build_exe.ps1 first (unless -SkipExe), then compiles the Inno Setup
# script. FfmpegDir must contain ffmpeg.exe (and ideally ffprobe.exe); when
# omitted, the directory of the ffmpeg on PATH is used. All dependencies are
# bundled -- the installer performs no downloads.

param(
    [string]$FfmpegDir = "",
    [string]$Iscc = "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe",
    [switch]$SkipExe
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot

if (-not $SkipExe) {
    & (Join-Path $PSScriptRoot "build_exe.ps1")
}
if (-not (Test-Path (Join-Path $repoRoot "dist\QuillRadio.exe"))) {
    throw "dist\QuillRadio.exe not found; run scripts\build_exe.ps1 first."
}

if (-not $FfmpegDir) {
    $ffmpeg = Get-Command ffmpeg -ErrorAction SilentlyContinue
    if ($ffmpeg) { $FfmpegDir = Split-Path -Parent $ffmpeg.Source }
}
if (-not $FfmpegDir -or -not (Test-Path (Join-Path $FfmpegDir "ffmpeg.exe"))) {
    throw "ffmpeg.exe not found. Pass -FfmpegDir; recording and audio processing must ship bundled."
}
if (-not (Test-Path $Iscc)) {
    $fallback = "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe"
    if (Test-Path $fallback) { $Iscc = $fallback } else { throw "ISCC.exe not found: $Iscc" }
}

& $Iscc (Join-Path $repoRoot "installer\quill-radio.iss") `
    "/DFfmpegDir=$FfmpegDir" `
    "/O$(Join-Path $repoRoot 'dist')"
if ($LASTEXITCODE -ne 0) { throw "ISCC failed with exit code $LASTEXITCODE" }
Write-Host "Installer written to $(Join-Path $repoRoot 'dist')"
