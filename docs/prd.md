# Quill Radio -- Product Requirements

Version 2.0

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
- Recordings list: live status (Recording with growing size / Recorded / Scheduled), Play, Stop Recording, Open in Folder, Remove. Refresh is an in-place diff keyed by file path (no-op when unchanged; selection/focus/scroll preserved), not a rebuild; the active row shows a live elapsed time and scheduled rows show their zone-labeled times; the tray tooltip carries "(recording)".
- Auto-reconnect: ffmpeg HTTP reconnect flags plus process-level retry into numbered part files; enabled/attempts/spacing configurable; user stops and duration-cap finishes never retry.
- Settings: format (mp3/ogg/flac/wav, plus a raw stream-copy mode), bitrate, destination, filename pattern with tokens, max-duration safety cap.
- Raw/lossless capture (upstream `core/radio/recording.py`, listener request): a "Raw stream -- exactly as sent, no re-encoding (lossless)" format (`format="copy"`) stream-copies the server's audio packets with ffmpeg's `-c:a copy` -- no decode, no re-encode -- so the saved file is bit-for-bit the original broadcast, the most faithful capture for a listener who wants to do their own lossless editing/conversion. Bitrate and Sound Enhancements are meaningless with no re-encode and are dropped. The output container follows the stream's own codec, chosen from a one-time bounded `ffprobe` of the first audio stream (mp3->`.mp3`, aac->`.aac`, vorbis->`.ogg`, opus->`.opus`, flac->`.flac`, ...), falling back to Matroska audio (`.mka`) for anything unrecognized -- a universal lossless copy container; a missing/failed probe degrades to `.mka` rather than blocking the recording, and the resolved extension is reused across auto-reconnect continuation files.
- Recording reliability (upstream `quill/core/radio/*`, 2.0.0; R1-R4): a reported round of recording bugs closed in four phases, delivered in the 2.0.0 release. (R1) the Recordings list is an in-place diff keyed by file path -- a screen reader is no longer yanked to the top mid-read; the active recording is counted from the recorder itself (a temp-folder recording is no longer invisible), a firing schedule is no longer double-counted, completed one-time entries drop out of the scheduled count, and the active row shows a live elapsed time. (R2) the scheduler uses a next-due-timestamp window model (an entry is due from `start` through `start + duration`, so a late arrival starts with the remaining minutes and launch catch-up is free); `last_fired` is stamped by entry id only on a successful start, `once` entries auto-disable after firing, a same-minute conflict defers via `on_busy`, and the scheduler thread is lock-guarded and can no longer die silently. (R3, new feature) resume across restart: an `ActiveRecordingMarker` is written at start and cleared on a clean stop (a crash leaves it); on launch, `reconcile_temp_strays` moves finished temp orphans to the destination and leaves a still-writing file untouched, then per `RadioHistory.recording_resume_choice` (`ask`|`always`|`never`, default `ask`) Quill Radio offers to resume for the remaining minutes within a 10-minute grace via an accessible dialog (Resume/Skip/Don't-ask-again; a corrupt marker is discarded). (R4) pipeline hardening: a reconnect records only the remaining time to `_scheduled_end` (not a fresh full duration); `uniquify()` replaces the unconditional `-y` overwrite and continuation parts keep the original start timestamp; a drop is classified fatal (disk full / HTTP 4xx) vs transient (5xx/network) before any reconnect attempt is spent; and on Windows ffmpeg runs in a job object with `JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE` so a crashed host takes the child down, with the stop wait moved off the UI thread. Everything lands in the shared `quill` package; nothing is vendored into the wrapper.

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
- P-2. Everything bundled, nothing downloaded at install or runtime: the onedir build carries the whole quill package and data; ffmpeg installs to {app}\tools\ffmpeg and libmpv (the mpv playback engine, with its GPL license texts and source-offer note) to {app}\tools\mpv, both found via the wrapper exporting QUILL_APP_ROOT. A portable zip ships the same onedir build plus a `data\` folder that switches storage to travel with the app.
- P-3. Uninstall never deletes `%APPDATA%\Quill` -- QUILL or QUILL Cast may still use it.
- P-4. Release artifacts: `Quill-Radio-Setup-<version>.exe`, tagged `v<version>`, which Help > Check for Updates compares against and downloads.

## 6. Network requirements

- N-1. Every outbound surface is inventoried in QUILL's network-egress audit: RadioBrowser and SomaFM (search/tags/countries/click-votes/byuuid fallback), the user-typed page for Find Streams (plus, for a Triton/StreamTheWorld player page, one follow-on call to Triton's provisioning API to resolve the JS-computed stream), the playing stream itself for ICY titles, and this repository's GitHub releases for the update check. No telemetry of any kind. (Sound Enhancements' local relay, §8, is loopback-only and never reaches the network itself -- it filters the same stream this section already covers.)
- N-2. Safe Mode disables the radio's network surfaces along with the feature.

## 7. Non-goals

macOS/Linux standalone builds (upstream QUILL covers macOS; the tray pattern does not exist there), auto-updating in place, telemetry. A full DSP effects rack (reverb, tempo/pitch, spatial audio) -- Sound Enhancements (§8) is a small, purpose-built three-band EQ and compressor, not a general effects rack.

## 8. Since 1.0

- **Recordings reliability overhaul (2.0.0, upstream `quill/core/radio/*`; R1-R4).** The headline of 2.0.0: a reported round of recording bugs closed and the one missing piece added -- a recording that survives a restart. Resume across restart with an ask-on-launch dialog and a 10-minute grace window; window-based scheduling with launch catch-up; a flicker-free, place-keeping Recordings list with honest counts and a live elapsed time; and pipeline hardening against dropped connections, dead streams, and a crashed host. Detailed as delivered scope in §3 (Recording). Everything lands in the shared `quill` package; nothing is vendored into the wrapper.
- **The mpv playback engine (1.1.0, upstream `quill/ui/radio/mpv_radio_engine.py` + `player_controller.py`, #1076).** A second, preferred audio backend: libmpv, live-stream-aware (readiness from `core-idle`, not the duration a live stream never reports), bundled at `{app}\tools\mpv`. `RadioHistory.playback_engine` = auto (mpv when present) / wx ("Windows Media (classic)", the byte-for-byte pre-1.1 escape hatch) / mpv; one silent cross-engine rescue per play attempt in either direction. Combined stream-format coverage is effectively complete: MP3, AAC and HE-AAC (AAC+), Ogg Vorbis, Opus, FLAC streams, and HLS (m3u8) -- Ogg Vorbis/Opus/HLS were undecodable by WMP. The engine delivers: **Radio output device** (Preferences; `RadioHistory.output_device`; screen reader and app sounds stay on the system default; unplugged devices remembered, spoken fallback when unusable); **live DVR** (a seekable ~45-minute demuxer cache: pause/resume live radio, Rewind/Forward 30 Seconds, Back to Live, each announcing how far behind live); **Volume Boost** (up to 150% for quiet stations; the 0-100 scale, per-station volumes, and mute untouched); **engine-native What's Playing fallback** (mpv `media-title` when the ICY side-tap gets nothing or the stream is HLS); and **"Buffering..." announcements** on mid-stream stalls.
- **Sound Enhancements** (Playback > Sound Enhancements...): a three-band equalizer (Bass/Mid/Treble sliders, -12 to +12 dB) and a compressor, applied live via an ffmpeg filter graph relayed to the playback engine over a loopback-only local HTTP server -- or, on the mpv engine (1.1.0), natively inside the player with no relay and with changes heard live, no reconnect. Off by default. 1.1.0 adds two listener-level (deliberately global, not per-station) options riding the same shared graph everywhere including recordings: **mono downmix** (single-sided hearing / one earbud -- hard-panned content never disappears) and **night mode** (real-time loudness normalization lifting quiet passages), plus the Small Speakers and Late Night quick presets. A "Quick preset" shortcut sets all three sliders at once. Remembered per favorite station (a whole-record override on `FavoriteStation`, mirroring QUILL Cast's per-podcast override) as well as a shared default in `RadioHistory`; `RadioPlayerController` resolves which applies via an injected callback at the top of every `play_station`. Recording Settings' "Apply Sound Enhancements to recordings" (off by default) optionally records the filtered audio too.
- **SomaFM**, a second free, keyless station directory, blended into Browse Stations search alongside RadioBrowser.
- **Exit/Minimize to Tray confirmation**: closing the window asks Exit, Minimize to Tray, or Cancel (with a one-time "Don't ask me again"), instead of always exiting immediately and silently stopping an in-progress recording. Adjustable in Preferences.
- **Quieter dialogs and a real "up to date" answer**: dialog-transition announcements are now off by default (Preferences), and a manual Check for Updates that finds nothing newer shows a dialog instead of only announcing it.
- **In-app documentation**: Help > User Guide / Release Notes / Product Requirements open the bundled docs in your browser.

See `CHANGELOG.md` for the full, versioned history.
