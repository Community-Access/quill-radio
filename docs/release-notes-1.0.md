# Quill Radio 1.0 -- Release Notes

The radio, on its own -- and finished. Quill Radio takes the internet radio QUILL users already know, gives it a window, a menu bar, a tray icon, and its own icon, and then goes further than the embedded radio ever has. Everything below also landed in QUILL itself: the two share one codebase and one data store, so features arrive everywhere at once.

## Unreleased

- **What's Playing, the way you'd actually say it.** Some stations don't send a clean "Artist - Title" -- their broadcast systems cram a pile of catalog codes into the track name, and What's Playing (Ctrl+T) read the whole thing aloud: `title="YOUR SONG",artist="Elton John",url="song_spot="F" MediaBaseId="0"...`. Now Quill Radio finds the title and the artist in that noise and just says "Now playing: YOUR SONG by Elton John." Better still, you decide the wording: Preferences (Ctrl+,) has a "What's Playing announcement" box where you write a short template with `{title}` and `{artist}` -- wrap optional words in `[square brackets]` so they disappear when there's nothing to fill them (the default `{title}[ by {artist}]` quietly drops the " by" when a stream sends no artist). Prefer "Elton John: YOUR SONG"? Type `{artist}: {title}`. Want the raw feed for a station you're curious about? `{raw}` gives you everything. Blank restores the default.
- **The whole dial, not just the first 50.** Browse Stations used to stop at 50 results -- so a search for "news," with hundreds of stations out there, looked like it only had 50 in the world. Now you get up to 200 at once, most-listened first, and when there are still more a **More Stations** button loads the next page and drops your cursor right on the first new arrival. The summary even tells you when there's more to reach for, and nudges you to add a tag or country when you'd rather narrow than page. Under the hood this pages the RadioBrowser directory properly, so the long tail is finally within reach.
- **Volume keys, fixed again -- this time in Browse Stations.** Search for a station, press Enter to play it, then reach for Ctrl+Down to bring the volume down... and nothing happened. Browse Stations is its own window, so the Playback menu's volume shortcut never reached it, and the station results list had already claimed the plain arrow keys for moving between rows. Now Ctrl+Up and Ctrl+Down work from anywhere in that window -- the results list, the volume slider, a button -- turning the same radio volume you'd change anywhere else, sliding the window's own volume control to match, and speaking the new level. Plain arrow keys still move you between stations, untouched. (Version 1.0.2 fixed exactly this on the main window's Favorites list; this reaches the Browse Stations window that fix didn't.)
- **Find Streams now reaches the stations that hid behind a Play button.** A whole class of broadcast stations -- thousands of them, and the entire `player.listenlive.co` network -- put their "Listen Live" on a modern JavaScript player (Triton Digital / StreamTheWorld). Those players build the stream address in code the moment you press Play, so it is written nowhere on the page for a scanner to read. Point the old Find Streams at one and it came back empty, even with a Play button sitting right there on the screen. No longer: Quill Radio now recognizes the player, reads the station's call letters straight off the page, and looks up the real, playable stream through the station provider's own public address service -- no embedded browser, no guessing at URLs. When a station offers both an MP3 and an AAC feed, you get both to choose from. It only ever does this for pages that really are these players and only for call letters the service confirms, so it never hands you a wrong stream; ordinary pages behave exactly as before, and the lookup happens as part of the same Scan you already press (and stays off in Safe Mode). One real report -- `player.listenlive.co/34461`, "Magic 104.1" -- turned into a fix that quietly covers thousands of stations at once.

## What's new in 1.0.2

- **Volume keys, fixed.** Ctrl+Up/Ctrl+Down did nothing from the Favorites tree, which has focus by default when the app launches -- the tree's own arrow-key handling was silently swallowing the shortcut before it ever reached Volume Up/Down. Fixed.
- **Volume that actually stays put.** Starting a stream -- or just pausing and resuming one -- could silently reset the volume to 100, even overwriting a favorite station's own remembered volume in the process. A favorite now reliably comes back at the volume you left it, and if you set a volume before playing something with no memory of its own yet, it stays exactly where you put it.
- **Sound Enhancements' EQ sliders now announce a real accessible name to screen readers.**
- **Reset Sound Enhancements back to default.** A "Reset to Default" button in Sound Enhancements clears a station's own EQ/compressor override, so it goes back to following the shared default. Preferences (Ctrl+,) gained "Reset All Stations' Sound Enhancements..." to clear every station's override at once, with a confirmation first.
- **A real three-band equalizer.** Sound Enhancements' single preset choice became Bass, Mid, and Treble sliders (-12 to +12 dB each), freely adjustable. The old presets (Flat, Bass Boost, Voice Clarity, Podcast) are still there as a "Quick preset" shortcut -- pick one to set all three sliders at once, then keep tuning from there.
- **Sound Enhancements, remembered per station.** Open Sound Enhancements while a favorite station is playing and it now remembers that station's own EQ and compressor separately from the shared default -- a jazz station and a talk station no longer have to sound the same. With nothing playing (or a non-favorite station on), you're adjusting the shared default every other station still follows.
- **Exit or Minimize to Tray -- your choice.** When something is playing or recording, closing asks: Exit, Minimize to Tray, or Cancel, with a "Don't ask me again" checkbox that remembers your answer. Preferences (Ctrl+,) gained a matching "When closing the window" setting so you can always change your mind later.
- **A real dialog when you're already up to date.** Help > Check for Updates used to only announce "up to date" -- easy to miss. It now shows a proper dialog, the same as a genuine update does.
- **Quieter by default.** Preferences (Ctrl+,) gained "Announce dialog transitions" (off by default) -- previously every dialog spoke "Entered/Exited" cues with no way to turn it off.
- **Documentation, right in the Help menu.** User Guide, Release Notes, and Product Requirements now open directly from Help, rendered in your browser.
- **Sound Enhancements.** Playback > Sound Enhancements... adds an equalizer preset (Flat, Bass Boost, Voice Clarity, Podcast) and a compressor ("Even Out Volume", boosts quiet passages and tames loud ones) to whatever station is playing, applied live through the ffmpeg Quill Radio already uses for recording. Off by default, and turning either one on reconnects instantly -- live radio has no position to lose. **Recording Settings...** gained a matching "Apply Sound Enhancements to recordings" checkbox (off by default) if you'd rather your recordings capture the filtered audio too.
- **A second station directory.** Browse Stations search now also checks SomaFM, a free, curated internet-radio directory, blended right into the same results as RadioBrowser -- more stations to find, no extra step.
- **Automatic Check for Updates.** Quill Radio quietly checks for a newer version once a day when it launches -- silent unless a real update is found, at which point you get the same "download it now?" prompt Help > Check for Updates always gave you. Throttled so it never hits the network on every single launch.
- **Preferences...** (Ctrl+,) is a new, small dialog gathering the app's startup behavior in one place: Resume Last Station on Launch and the new automatic update check, each its own checkbox. Turning either off takes effect immediately.
- **Dialog buttons that match Windows convention.** Recording Settings, the Wake-Up Timer, and Add Station now say "OK" instead of "Save," like a standard Windows dialog.

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
