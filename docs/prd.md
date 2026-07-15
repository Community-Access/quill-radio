# Quill Radio -- Product Requirements

Version 1.0

## 1. Product statement

Quill Radio is QUILL's internet radio, shipped as its own small Windows app for people who want the radio on without loading a full writing environment. It is screen-reader-first, keyboard-complete, and deliberately small -- and by 1.0 it is a complete radio product: organization, recording resilience, timers, and appliance-grade startup.

## 2. Architecture requirement: not a fork

- R-1. All feature code lives in the upstream `quill` package (`quill.apps.radio`, `RadioMixin`, `AppShellFrame`, `quill/core/radio/*`, `quill/ui/radio/*`). This repository contains only the product wrapper (entry point, icon, installer, docs). Nothing here reimplements a feature.
- R-2. The app stays in sync with QUILL by construction: the wrapper depends on `quill` from the upstream repository, and the one-file build pulls the entire package. Divergence is only permitted for content that exists because QUILL is not in the picture.
- R-3. Data is shared, not copied: favorites (folders, custom names, per-station volumes), recently-played history, recordings, schedules, the wake-up timer, and settings live in the same `%APPDATA%\Quill` store QUILL uses.
- R-4. Keystrokes are the app's own (menu accelerators), kept separate from QUILL's keymap so nothing collides with editor shortcuts.

## 3. Scope (all reused from upstream; all shipped in 1.0)

**Listening**
- Station browser over the RadioBrowser directory (search, tag/country filters, test-play, favorite); bundled ACB Media directory; custom stream URLs; website stream finder with a Test/Stop Test toggle.
- One transport control (Play becomes Stop), mute, volume with per-station memory, single-player rule (starting any stream silences sibling media, radio or podcast, in every app).
- Recently Played (capped, de-duplicated), Play Last Station, optional resume-on-launch.
- What's Playing: ICY track titles on demand and optional announce-on-change (off by default).
- Stream fallback: a directory station whose stream errors is re-fetched by uuid and retried once, self-healing the saved favorite.

**Organization**
- Favorites Manager: nested path-based folders, live rich search, Move Up/Down, Mark-and-Move (Move Above/Below adopting the destination folder), station rename (custom display names used everywhere), folder rename carrying descendants, folder delete that returns stations to the top level.

**Recording**
- Record now; Record Station (a different station than the one playing, for N minutes); scheduled recordings (once/daily/weekly).
- Recordings list: live status (Recording with growing size / Recorded / Scheduled), Play, Stop Recording, Open in Folder, Remove, 2-second auto-refresh.
- Auto-reconnect: ffmpeg HTTP reconnect flags plus process-level retry into numbered part files; enabled/attempts/spacing configurable; user stops and duration-cap finishes never retry.
- Settings: format (mp3/ogg/flac/wav), bitrate, destination, filename pattern with tokens, max-duration safety cap.

**Timers**
- Sleep timer (shared radio/podcasts fade-and-restore).
- Wake-up timer: once or daily at HH:MM; fires only within a 5-minute window (never retro-fires); "once" disables itself; requires the app running (tray counts); honest about that in the UI.

**Shell**
- System tray with full controls and the app's own icon; Send to Tray (Ctrl+W) and Exit; hardware media keys (play/pause, stop) system-wide while running, never stolen from an app that already owns them, released on exit.
- Command Palette scoped to the app's registry; Redeem Unlock Code (shared store); in-app update check that downloads the installer with spoken progress and offers Install now; About.
- Unlock-gated Audio Description Project menu when `future.adp_assistant` is unlocked.

Out of scope by decision: QUILL's editor, AI, speech transcription, braille, and TTS stacks (not installed); a custom update engine beyond download-and-run.

## 4. Accessibility requirements

- A-1. Every interactive element has an accessible name; upstream inventory gates audit the shared surfaces.
- A-2. Focus lands on the favorites list at launch; focus dead zones are defects.
- A-3. All dialogs route through the shared dialog contract (modal ids, focus placement, region announcements) and are registered in the dialog inventory.
- A-4. Every action announces its outcome; silent state changes are defects. Track-title announcements are opt-in so ambient chatter never surprises anyone.
- A-5. Full keyboard operation including manager reordering and the tray menu; Delete/F2/Enter conventions consistent across lists.

## 5. Packaging requirements

- P-1. PyInstaller onedir build with the app's own icon; Inno Setup installer with its own AppId installing to {autopf}\Quill Radio, per-user by default.
- P-2. Everything bundled, nothing downloaded at install or runtime: the onedir build carries the whole quill package and data; ffmpeg installs to {app}\tools\ffmpeg, found via the wrapper exporting QUILL_APP_ROOT. A portable zip ships the same onedir build plus a `data\` folder that switches storage to travel with the app.
- P-3. Uninstall never deletes `%APPDATA%\Quill` -- QUILL or QUILL Cast may still use it.
- P-4. Release artifacts: `Quill-Radio-Setup-<version>.exe`, tagged `v<version>`, which Help > Check for Updates compares against and downloads.

## 6. Network requirements

- N-1. Exactly four outbound surfaces, each inventoried in QUILL's network-egress audit: RadioBrowser (search/tags/countries/click-votes/byuuid fallback), the user-typed page for Find Streams, the playing stream itself for ICY titles, and this repository's GitHub releases for the update check. No telemetry of any kind.
- N-2. Safe Mode disables the radio's network surfaces along with the feature.

## 7. Non-goals

macOS/Linux standalone builds (upstream QUILL covers macOS; the tray pattern does not exist there), auto-updating in place, telemetry.
