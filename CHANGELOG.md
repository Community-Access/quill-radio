# Changelog

All notable changes to Quill Radio are documented here. See `docs/release-notes-1.0.md` for the fuller narrative version.

## Unreleased

- What's Playing (Ctrl+T) now reads a clean title and artist. Some stations pack a wall of broadcast metadata into the track title -- you'd hear `title="YOUR SONG",artist="Elton John",url="song_spot="F" MediaBaseId="0" ...` read out in full. Quill Radio now pulls out just the title and artist, so you hear "Now playing: YOUR SONG by Elton John". And you can decide exactly how it's phrased: Preferences (Ctrl+,) gained a "What's Playing announcement" box where you write a small template with `{title}` and `{artist}` tokens -- put optional wording in `[square brackets]` to hide it when a field is empty (the default `{title}[ by {artist}]` drops the " by" when a stream gives no artist). `{raw}` is the stream's exact original text if you ever want all of it. Leave the box blank to restore the default.
- Browse Stations now shows up to 200 stations per search instead of 50, and pages beyond that. A broad search like "news" used to stop at 50 with no way to see the rest; now you get up to 200 most-listened-first, and when there are more, a "More Stations" button appears to load the next page (it lands your cursor on the first new station and tells you how many were added). The results summary tells you when there's more to load and suggests adding a tag or country to narrow things down.
- Fixed: Ctrl+Up / Ctrl+Down (Volume Up/Down) did nothing inside the Browse Stations window. After you searched for a station and pressed Enter to play it, the volume shortcut was swallowed -- the station results list claims the plain arrow keys for moving between rows, and because Browse Stations is its own window the menu's volume shortcut never reached it. The volume keys now work from anywhere in that window (the results list, the volume slider, or a button), adjust the same radio volume as everywhere else, move the window's own volume slider to match, and announce the new level. Moving between stations with the plain arrow keys is unchanged. (The 1.0.2 fix covered the same problem on the main window's Favorites list; this covers the Browse Stations window it did not reach.)
- Find Streams from a Website now works for stations whose "Listen Live" button is a modern JavaScript player -- Triton Digital / StreamTheWorld, including the whole `player.listenlive.co` network (for example `player.listenlive.co/34461`, "Magic 104.1"). Those players build their stream address in code, so it is written nowhere in the page for a scanner to read, and the old scan came back empty even though a Play button was right there on the screen. Quill Radio now recognizes the player, reads the station's call letters from the page, and looks the real stream up through the station provider's own public address service -- no embedded browser, no guessing. Both the MP3 and the AAC stream are offered when a station publishes both. Non-player pages are unaffected, and the lookup only happens as part of the same explicit Scan you already run (and is disabled in Safe Mode). Implemented upstream in the shared Quill code (`core/radio/triton.py`), so QUILL gets it too.

## 1.0.2

- Fixed: Ctrl+Up/Ctrl+Down (Volume Up/Down) did nothing from the Favorites tree, which has focus by default on launch -- the tree's own arrow-key handling was silently swallowing the shortcut before it ever reached the Playback menu.
- Fixed: starting a stream (or pausing and resuming one) could reset the volume to 100, discarding a level you'd just set and, for a favorite station, silently overwriting its own remembered volume. A favorite now reliably comes back at its own remembered volume; a level you set with nothing memorized yet stays put.
- Fixed: Sound Enhancements' EQ sliders now announce a real accessible name to screen readers.
- The Recording Settings, Wake-Up Timer, and Add Station dialogs' affirmative button is now labeled "OK" instead of "Save," matching standard Windows dialog convention.
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
