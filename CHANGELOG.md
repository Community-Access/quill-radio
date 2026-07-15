# Changelog

All notable changes to Quill Radio are documented here. See `docs/release-notes-1.0.md` for the fuller narrative version.

## 1.0.2

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
