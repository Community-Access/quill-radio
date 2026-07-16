# Changelog

All notable changes to Quill Radio are documented here. See `docs/release-notes-1.0.md` for the fuller narrative version.

## 1.0.2

- Fixed: Ctrl+Up/Ctrl+Down (Volume Up/Down) did nothing from the Favorites tree, which has focus by default on launch -- the tree's own arrow-key handling was silently swallowing the shortcut before it ever reached the Playback menu.
- Fixed: closing the window (Alt+F4, the titlebar X, or Exit) could leave the app completely unresponsive if a second close attempt landed while the confirmation dialog was still opening. Closing now also skips the confirmation prompt entirely when nothing is playing or recording -- it just closes.
- Fixed: Sound Enhancements' EQ sliders now announce a real accessible name to screen readers.
- Sound Enhancements gained a "Reset to Default" button, clearing a station's own EQ/compressor override so it goes back to following the shared default. Preferences (Ctrl+,) gained "Reset All Stations' Sound Enhancements..." to clear every station's override at once.
- Sound Enhancements is now a real three-band equalizer: Bass, Mid, and Treble sliders (-12 to +12 dB), each freely adjustable. The old presets (Flat/Bass Boost/Voice Clarity/Podcast) still work as a "Quick preset" shortcut that sets all three sliders at once.
- Sound Enhancements can now be remembered **per station**: open it while a favorite station is playing to give that station its own EQ and compressor, distinct from the shared default. Adjust it with nothing playing (or a non-favorite station on) to change the shared default that every other station follows.
- Closing the window (the titlebar X, Alt+F4, or Station > Exit) now asks what to do when something is playing or recording: Exit, Minimize to Tray, or Cancel, with a "Don't ask me again" checkbox -- previously it always exited immediately, silently stopping an in-progress recording. Preferences (Ctrl+,) gained a matching "When closing the window" setting to change your answer later.
- Check for Updates (Help menu) now shows a real dialog when you're already up to date, instead of only a spoken announcement that was easy to miss.
- Preferences (Ctrl+,) gained "Announce dialog transitions" (off by default) to reduce alert noise -- previously every dialog always spoke "Entered/Exited" cues with no way to turn it off.
- Help menu gained User Guide, Release Notes, and Product Requirements items, opening the bundled documentation right in your browser.
- Sound Enhancements (Playback > Sound Enhancements...): an equalizer preset (Flat/Bass Boost/Voice Clarity/Podcast) plus a compressor ("Even Out Volume"), applied live via ffmpeg -- no new audio engine, no new install step. Off by default; needs FFmpeg (Help > Get FFmpeg...) the same way recording already does.
- Recording Settings gained "Apply Sound Enhancements to recordings" -- off by default (an unfiltered archival copy, unchanged behavior), turning it on records the filtered audio instead for every recording method (Record Now, Record Station, and scheduled recordings).
- Browse Stations search now also checks SomaFM (a free, curated internet-radio directory) alongside RadioBrowser, blended into the same results list.
- Automatic Check for Updates: a throttled, silent check once a day on launch -- quiet unless a real update is found.
- Preferences... (Ctrl+,): a small dialog for Resume Last Station on Launch and the new automatic update check.

## 1.0.1

- Fixed: Check for Updates, the in-app update download, and Help > Get FFmpeg failed with an internal error ("unexpected keyword argument cancellation_token").

## 1.0.0

- Initial public release: the next generation of the ACB Radio Tuner.
- Favorites tree on the main page with a full context menu (Play/Stop, Rename, Move to Folder, Remove, New Folder).
- Favorites-first appliance behavior: Play Last Station (Ctrl+L), Resume Last Station on Launch, Recently Played.
- Favorites Manager: nested folders, live search, Move Up/Down, Mark-and-Move.
- What's Playing (Ctrl+T) with optional live title announcements.
- Recording: record what's playing or a different station, scheduled recordings (once/daily/weekly), a Recordings list, and auto-reconnect on a dropped connection.
- Wake-Up Timer (the sleep timer's twin).
- Never-double-play across radio and podcasts.
- Per-station volume memory.
- Hardware media key support.
- Command Palette scoped to Quill Radio's own commands.
- Installer and portable flavors, everything bundled (ffmpeg included).
- Report a Bug and Check for Updates, both stamped with Quill Radio's own identity and version.
