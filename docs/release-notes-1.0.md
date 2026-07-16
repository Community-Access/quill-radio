# Quill Radio 1.0 -- Release Notes

The radio, on its own -- and finished. Quill Radio takes the internet radio QUILL users already know, gives it a window, a menu bar, a tray icon, and its own icon, and then goes further than the embedded radio ever has. Everything below also landed in QUILL itself: the two share one codebase and one data store, so features arrive everywhere at once.

## What's new in 1.0.3

- **Sound Enhancements.** Playback > Sound Enhancements... adds an equalizer preset (Flat, Bass Boost, Voice Clarity, Podcast) and a compressor ("Even Out Volume", boosts quiet passages and tames loud ones) to whatever station is playing, applied live through the ffmpeg Quill Radio already uses for recording. Off by default, and turning either one on reconnects instantly -- live radio has no position to lose. **Recording Settings...** gained a matching "Apply Sound Enhancements to recordings" checkbox (off by default) if you'd rather your recordings capture the filtered audio too.
- **A second station directory.** Browse Stations search now also checks SomaFM, a free, curated internet-radio directory, blended right into the same results as RadioBrowser -- more stations to find, no extra step.

## What's new in 1.0.2

- **Automatic Check for Updates.** Quill Radio quietly checks for a newer version once a day when it launches -- silent unless a real update is found, at which point you get the same "download it now?" prompt Help > Check for Updates always gave you. Throttled so it never hits the network on every single launch.
- **Preferences...** (Ctrl+,) is a new, small dialog gathering the app's startup behavior in one place: Resume Last Station on Launch and the new automatic update check, each its own checkbox. Turning either off takes effect immediately.

## Highlights

- **Your folders, on the front page.** The main window is your favorites tree -- the same nested folders you build in the manager, with a full context menu (Play/Stop, Rename, Move to Folder, Remove, New Folder) one Shift+F10 away. Create folders exactly where you want them with **New Folder** (Ctrl+Shift+E); they exist immediately, stations or not. An **Add to Favorites** button keeps whatever is playing, and flips to Remove when it's already saved.
- **Favorites first, radio as an appliance.** The app opens with your favorites focused; Enter plays. **Play Last Station** (Ctrl+L) resumes whatever you had on, and **Resume Last Station on Launch** makes launching the app all you ever do. A **Recently Played** menu keeps your last fifteen stations one keystroke deep.
- **A real Favorites Manager.** Folders of any depth (News/Morning style), live search across names, countries, tags, and folders, Move Up/Down, and Mark-and-Move for long hops. Rename any station to what *you* call it; rename folders with F2; deleting a folder walks its stations safely back to the top level -- never out of your collection.
- **What's Playing.** Ctrl+T speaks the current track or show title straight from the stream's metadata; an optional check item announces titles as they change.
- **Recording, grown up.** Record what you're hearing, record a *different* station while you listen to something else, or schedule shows once, daily, or weekly -- picking straight from your favorites, no typing. The new **Recordings** list shows everything -- recording now (size growing live), recorded, and scheduled -- with Play (Stop while it plays), Stop Recording, Open in Folder, and Remove. And recordings now **survive dropped connections**: ffmpeg rides out short gaps, and a true drop resumes into a numbered part file, with attempts and spacing yours to tune.
- **Wake up with the radio.** The sleep timer got its twin: pick a favorite, a time, once or every day. (The app must be running -- the tray counts.)
- **Never double-plays.** Starting any stream silences whatever else was playing, radio or podcast, in every app.
- **Per-station volume memory.** Every favorite remembers the volume you gave it.
- **Hardware media keys** control the app system-wide, even from the tray.
- **The Command Palette** (Ctrl+Shift+P), scoped to exactly this app's commands.
- **One data store.** Favorites (folders, names, volumes), history, recordings, timers, settings -- shared with QUILL and QUILL Cast. Set it up once, have it everywhere.
- **Two flavors, everything bundled.** A system installer and a truly portable zip whose `data` folder keeps your whole radio on the stick. ffmpeg included, its own app icon, no downloads ever -- and if ffmpeg somehow goes missing, **Help > Get FFmpeg...** restores it from the official source. In-app **Check for Updates** knows which flavor you run and downloads the matching artifact with spoken progress, offering Install now.
- **Report a Bug, built in.** Files an issue straight from the Help menu, no GitHub account needed, stamped with Quill Radio's own version.
- **Spoken feedback everywhere**, through JAWS, NVDA, or Narrator, without stealing focus.

## Known notes for this release

- Releases are not yet code-signed: Windows SmartScreen may warn on first run. Choose More info, then Run anyway. Signing is planned.

## What Quill Radio deliberately is not

It is not QUILL minus some menus -- it is the radio, period. The editor, AI, transcription, braille, and speech-synthesis stacks are not installed at all.

## Not a fork -- a guarantee

Quill Radio runs the exact same radio feature code as QUILL, from the same upstream package. Fixes land once and reach QUILL, Quill Radio, and QUILL Cast together. This repository carries only the wrapper, the installer, the icon, and these docs.

## Dependencies

Playback uses Windows' built-in media engine; recording and Sound Enhancements use the bundled ffmpeg; station search uses the community RadioBrowser and SomaFM directories; the ACB Media directory is bundled. Every network call the app can make is inventoried in QUILL's public network-egress audit.

## Requirements

Windows 10 or 11, x64 (or ARM64 under emulation). No Python installation required.
