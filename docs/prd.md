# Quill Radio -- Product Requirements

Version 1.0

## 1. Product statement

Quill Radio is QUILL's internet radio, shipped as its own small Windows app for people who want the radio on without loading a full writing environment. It is screen-reader-first, keyboard-complete, and deliberately small.

## 2. Architecture requirement: not a fork

- R-1. All feature code lives in the upstream `quill` package (`quill.apps.radio`, `RadioMixin`, `AppShellFrame`). This repository contains only the product wrapper (entry point, installer, docs). Nothing here reimplements a feature.
- R-2. The app stays in sync with QUILL by construction: the wrapper depends on `quill` from the upstream repository, and the installer payload is built from an upstream portable bundle. Divergence is only permitted for content that exists because QUILL is not in the picture (branding, installer, app docs).
- R-3. Data is shared, not copied: settings, favorites, and recordings live in the same `%APPDATA%\Quill` store QUILL uses. Subscribing/favoriting in one app is visible in all.

## 3. Scope

In scope (all reused from upstream):

- Station browser (search, filter, preview, favorite), custom stations, website stream finder.
- Favorites-first main panel; Enter plays.
- Playback transport: play/pause, stop, mute, volume, live now-playing line.
- Recording: record now, scheduled recordings, recording settings.
- System tray presence with playback controls.
- Announcement-engine speech through the user's screen reader.
- Help: Open in Quill, Redeem Unlock Code (shared unlock store), basic Check for Updates against this repo's releases, About.
- Unlock-gated Audio Description Project menu (top-level) when `future.adp_assistant` is unlocked.

Out of scope, by decision (D-1, "basic level of functionality"):

- QUILL's editor, AI assistants, transcription (whisper.cpp / Faster Whisper / Vosk), braille, neural TTS voice stacks (Kokoro/Piper), Pandoc conversions, Quillins. The installer excludes their payloads outright; the features QUILL fetches on demand are simply never requested by this app.
- A custom update engine. Check for Updates opens the release page; installing is the user's click.

## 4. Accessibility requirements

- A-1. Every interactive element has an accessible name; the inventory gate upstream audits the shared surfaces.
- A-2. Focus lands on the favorites list at launch; a bare-frame focus dead zone is a defect.
- A-3. All dialogs route through the shared dialog contract (modal ids, focus placement, region announcements).
- A-4. Every action announces its outcome through the announcement engine; silent state changes are defects.
- A-5. Full keyboard operation; the tray menu is reachable with keyboard alone.

## 5. Packaging requirements

- P-1. Inno Setup installer, own AppId, installs to its own directory ({autopf}\Quill Radio), per-user privileges by default.
- P-2. Payload = upstream portable bundle minus excluded components (tools\*, vendor\*, wheels\*, model stores, upstream docs); see installer/quill-radio.iss.
- P-3. Uninstall never deletes `%APPDATA%\Quill` -- QUILL or QUILL Cast may still use it. Only the full QUILL uninstaller owns that decision.
- P-4. Upgrade hygiene: the installer wipes its own `Lib\site-packages\quill` before re-laying files so module renames upstream never leave stale imports.

## 6. Update requirements

- U-1. Help > Check for Updates queries this repository's GitHub releases (newest stable vs running version) and offers the download page. No background checks in 1.0.
- U-2. Release artifacts are named `Quill-Radio-Setup-<version>.exe` and tagged `v<version>` so the check can compare.

## 7. Non-goals

macOS/Linux standalone builds (upstream QUILL covers macOS; the tray-icon pattern does not exist there), auto-updating in place, telemetry of any kind.
