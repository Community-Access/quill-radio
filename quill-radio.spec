# PyInstaller spec for the one-file Quill Radio build.
# Build with: pyinstaller quill-radio.spec  (see scripts/build_exe.ps1)
#
# collect_all("quill") brings the entire quill package -- code and package
# data (schemas, sounds, bundled quillins, assets) -- so nothing the shared
# feature code needs is missing from the frozen build. One file, windowed.

from PyInstaller.utils.hooks import collect_all

quill_datas, quill_binaries, quill_hiddenimports = collect_all("quill")

a = Analysis(
    ["launcher.py"],
    pathex=[],
    binaries=quill_binaries,
    datas=quill_datas,
    hiddenimports=quill_hiddenimports,
    hookspath=[],
    runtime_hooks=[],
    excludes=[
        # Basic app: QUILL fetches/uses these only for features Radio never
        # touches (transcription, neural TTS, science stacks).
        "faster_whisper",
        "vosk",
        "kokoro_onnx",
        "onnxruntime",
        "torch",
        "numpy.f2py",
    ],
    noarchive=False,
)

pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    name="QuillRadio",
    icon="assets/quill-radio.ico",
    console=False,
    upx=False,
    disable_windowed_traceback=False,
)
