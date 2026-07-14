# Quill Radio

Accessible, screen-reader-first internet radio as a standalone Windows app, from the QUILL project.

Quill Radio is not a fork. The whole application lives in the [quill](https://github.com/Community-Access/quill) package (`quill.apps.radio`) and runs the exact same radio feature code QUILL itself uses: the same station browser, favorites, recorder, scheduler, and dialogs. This repository holds only what exists because QUILL is not in the picture: the product wrapper (entry point), the installer, and this app's own documentation. Everything shared stays upstream, so Quill Radio tracks QUILL automatically.

## What it does

- Browse thousands of internet radio stations, keyboard-first, with a screen reader in mind at every step.
- Keep favorite stations one Enter press away; the favorites list has focus the moment the app opens.
- Record what you are hearing, or schedule a recording for later.
- Live in the system tray: close to tray, control playback from the tray menu.
- Share settings, favorites, and recordings with QUILL and QUILL Cast (one data store in `%APPDATA%\Quill`).
- Check for its own updates from Help > Check for Updates.

Deliberately not included: QUILL's editor, AI, transcription, braille, and speech-synthesis stacks. This is the radio, and just the radio. Help > Open in Quill launches the full editor when you want it.

## Install

Download `Quill-Radio-Setup-<version>.exe` from this repository's Releases page and run it. No Python required; the installer bundles the runtime. It installs to its own directory and never touches an existing QUILL install.

## Run from source

```powershell
pip install .
quill-radio
# or, with the quill package already installed:
python -m quill.apps.radio
```

## Build the installer

```powershell
# Requires a QUILL checkout that has produced its Windows portable bundle,
# and Inno Setup 6.3+ (ISCC.exe).
.\scripts\build_installer.ps1 -QuillRepo S:\QUILL
```

See `installer/quill-radio.iss` for exactly what ships; the payload excludes every on-demand and speech/braille component QUILL fetches at point of use.

## Documentation

- [User Guide](docs/userguide.md)
- [Release Notes](docs/release-notes-1.0.md)
- [Product Requirements](docs/prd.md)

## License

MIT, same as QUILL. See [LICENSE](LICENSE).
