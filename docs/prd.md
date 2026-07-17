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
- JavaScript-player resolution in the website stream finder (upstream `core/radio/triton.py`): Triton Digital / StreamTheWorld players (the `player.listenlive.co` network and thousands of broadcast stations) compute their stream URL in JavaScript, so it never appears in the page HTML and a plain-HTML scan finds nothing. Quill Radio detects the player, reads the station callsign from the Triton PWA's own logo asset name, and resolves it to a real playable mount through Triton's JS-free provisioning API (`playerservices.streamtheworld.com`), offering both the MP3 and AAC streams. Gated to pages that actually are Triton players and to a callsign the API validates, so it never surfaces a wrong stream; the response is parsed through the hardened `core/safe_xml` wrapper. One added egress, inventoried in QUILL's network-egress audit (§N-1), reached only from the same explicit Scan button and disabled in Safe Mode.
- One transport control (Play becomes Stop), mute, volume with per-station memory, single-player rule (starting any stream silences sibling media, radio or podcast, in every app).
- What's Playing (Ctrl+T) with a clean, configurable announcement (upstream `core/radio/now_playing.py`, #1068): parses the `key="value"` broadcast-automation metadata some stations pack into their ICY StreamTitle (and the plain "Artist - Title" convention) into title/artist fields, and renders them through a user-set token template (`{title}`/`{artist}`/`{raw}` with `[optional]` segments) stored in `RadioHistory.now_playing_template` and edited in Preferences (Ctrl+,). Default `{title}[ by {artist}]`.
- Paged station search (upstream `radio_browser.search_stations` offset + the Browse Stations dialog, #1064): 200 most-listened-first results per request (was 50) plus a More Stations button that pages the RadioBrowser directory beyond the first page; a finished search states when more exist and suggests narrowing.
- Self-healing stream recovery (upstream `core/radio/recovery.py`, #1065): on a playback error, a confidence-ordered ladder runs off-thread -- re-resolve a moved StreamTheWorld mount, refresh the URL from the directory, then (opt-in, `RadioHistory.recover_from_website`, default on, off in Safe Mode) scan the station's website with the shared Triton + "Listen Live" link-following scanner. A single unambiguous result auto-plays and self-heals the favorite; multiple candidates are announced for the user to pick in Find Streams. One attempt per station per session; all egress via the already-reviewed sites. `link_finder` also now follows a bounded allowlist of listen/live/play/tune-in `<a>` links one level deep, benefiting the manual Find Streams too.
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

- N-1. Every outbound surface is inventoried in QUILL's network-egress audit: RadioBrowser and SomaFM (search/tags/countries/click-votes/byuuid fallback), the user-typed page for Find Streams (plus, for a Triton/StreamTheWorld player page, one follow-on call to Triton's provisioning API to resolve the JS-computed stream), the playing stream itself for ICY titles, and this repository's GitHub releases for the update check. No telemetry of any kind. (Sound Enhancements' local relay, §8, is loopback-only and never reaches the network itself -- it filters the same stream this section already covers.)
- N-2. Safe Mode disables the radio's network surfaces along with the feature.

## 7. Non-goals

macOS/Linux standalone builds (upstream QUILL covers macOS; the tray pattern does not exist there), auto-updating in place, telemetry. A full DSP effects rack (reverb, tempo/pitch, spatial audio) -- Sound Enhancements (§8) is a small, purpose-built three-band EQ and compressor, not a general effects rack.

## 8. Since 1.0

- **Sound Enhancements** (Playback > Sound Enhancements...): a three-band equalizer (Bass/Mid/Treble sliders, -12 to +12 dB) and a compressor, applied live via an ffmpeg filter graph relayed to the playback engine over a loopback-only local HTTP server. Off by default. A "Quick preset" shortcut sets all three sliders at once. Remembered per favorite station (a whole-record override on `FavoriteStation`, mirroring QUILL Cast's per-podcast override) as well as a shared default in `RadioHistory`; `RadioPlayerController` resolves which applies via an injected callback at the top of every `play_station`. Recording Settings' "Apply Sound Enhancements to recordings" (off by default) optionally records the filtered audio too.
- **SomaFM**, a second free, keyless station directory, blended into Browse Stations search alongside RadioBrowser.
- **Exit/Minimize to Tray confirmation**: closing the window asks Exit, Minimize to Tray, or Cancel (with a one-time "Don't ask me again"), instead of always exiting immediately and silently stopping an in-progress recording. Adjustable in Preferences.
- **Quieter dialogs and a real "up to date" answer**: dialog-transition announcements are now off by default (Preferences), and a manual Check for Updates that finds nothing newer shows a dialog instead of only announcing it.
- **In-app documentation**: Help > User Guide / Release Notes / Product Requirements open the bundled docs in your browser.

See `CHANGELOG.md` for the full, versioned history.
