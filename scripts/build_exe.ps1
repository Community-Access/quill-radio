# Builds the one-file QuillRadio.exe with PyInstaller.
#
# Usage:
#   .\scripts\build_exe.ps1 [-Python <python.exe>]
#
# The Python environment must have the quill package (pip install
# "quill[ui] @ git+https://github.com/Community-Access/quill.git", or an
# editable install from a local checkout) plus pyinstaller.

param(
    [string]$Python = "S:\QUILL\.venv\Scripts\python.exe"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot

& $Python -c "import quill, PyInstaller" 2>$null
if ($LASTEXITCODE -ne 0) {
    throw "$Python needs the quill package and pyinstaller installed."
}

Push-Location $repoRoot
try {
    & $Python -m PyInstaller quill-radio.spec --noconfirm --distpath dist --workpath build
    if ($LASTEXITCODE -ne 0) { throw "PyInstaller failed" }
} finally {
    Pop-Location
}
Write-Host "Built $(Join-Path $repoRoot 'dist\QuillRadio.exe')"
