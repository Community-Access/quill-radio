# Quill Radio 2.0 -- Release Notes

Quill Radio 2.0 is about one thing done thoroughly: recordings you can trust. Version 1.1.0 rebuilt the sound -- a new playback engine, every stream format, live rewind, richer Sound Enhancements. 2.0 turns that same care on the recorder, closing a reported round of recording bugs and adding the one piece that was always missing: a recording that survives a restart. If you schedule shows, leave long recordings running unattended, or have ever come back to find a capture cut short or gone entirely, this release is for you.

It also widens the net for finding stations: **iHeart and TuneIn now join the search**, so two of the biggest directories on the internet are searchable and playable right inside Browse Stations. More on that below.

As always, everything below also lands in QUILL itself. Quill Radio and QUILL share one codebase and one data store, so these fixes arrive in both at once -- nothing here is vendored into the Quill Radio wrapper.

## Update 2.1.0

One-click updating, a new way to browse stations, and a round of fixes from live feedback, folded into this same release:

- **Browse a source without searching -- and several new sources.** You asked (thanks, Kelly) to be able to pick a source like SomaFM and just see its stations, without typing a search first. Now you can: the Browse Stations **Category** list lets you pick a source and the stations appear on their own. Alongside your Favorites you now get **Popular Stations**, **SomaFM**, **ACB Media**, **NFB Radio**, **TuneIn**, **Music Genres**, and the **Xiph Directory** -- each described below.
  - **Popular Stations** shows the most-listened stations on the internet right now (from the community RadioBrowser directory) -- a great "what's good?" starting point with nothing to type.
  - **SomaFM** lists SomaFM's whole channel lineup at once, so you can arrow through every channel instead of guessing a name.
  - **NFB Radio** is the National Federation of the Blind Radio Network (NFBRN), a speech-and-talk stream, bundled right alongside ACB Media so it's always one selection away.
  - **TuneIn** lets you browse TuneIn's own directory tree the way TuneIn does: pick **TuneIn** and you get its top-level folders -- **Music, Talk, Sports, Local Radio, By Location, By Language**, and more. Press **Enter** on a folder to open it, use the **"Up one level"** row to go back, and press Enter on a station to play it right there. No search required -- just wander in.
  - **Music Genres** is a big community catalog of music stations sorted by genre -- jazz, classical, 80s, country, ambient, and dozens more. Pick "Music Genres", choose a genre from the list that appears, and its stations load; the **Refresh** button re-pulls the newest genre list and stations from the internet whenever you like. This catalog is fetched live, on demand, from the public **m3u-radio-music-playlists** collection maintained by **junguler** (https://github.com/junguler/m3u-radio-music-playlists) -- with our thanks. Nothing is bundled or copied into Quill Radio; the lists are read on the spot, the same way RadioBrowser, SomaFM, and iHeart already are.
  - **Xiph Directory** browses the long-running, keyless **Icecast "yellow pages"** at **dir.xiph.org** by genre. Pick "Xiph Directory", choose a genre, and its stations load -- again fetched live on demand and refreshable with the same **Refresh** button. It is read the same on-the-spot way as every other directory.
- **SomaFM search ignores spacing and punctuation too.** Looking for a SomaFM channel no longer needs its exact spelling: "GrooveSalad", "groove-salad", or "salad groove" all find "Groove Salad", where before only an exact run of letters matched.
- **Update in one click -- Quill Radio installs it and restarts itself.** When an update is available, choose Download, then **Install and restart now**. Quill Radio applies the update for you -- extracting the new portable files over your current folder, or running the installer silently -- and relaunches automatically, keeping every favorite, recording, and setting exactly as it was. No more closing the app, hunting for the zip, unzipping it, and swapping folders by hand. This is shared across every Quill app, so QUILL, QUILL Cast, and Audio Studio update the same easy way.
- **Quill Radio no longer opens a second copy of itself.** If Quill Radio was already running -- even minimized to the system tray -- launching it again used to start a whole second instance. Now the copy already running simply comes to the front, and the second launch bows out. (#1152)
- **The Record button tells you when you are recording.** Once a recording begins, the Record button on the main window changes to **Stop Recording**, and changes back to **Record** when it stops -- so it is obvious at a glance (and to a screen reader) that a capture is running. (Recording has no pause, so this is a Record/Stop toggle.)
- **Volume changes are quiet again with a screen reader.** Holding Ctrl+Up or Ctrl+Down on a station you have saved used to speak the station's name -- and sometimes a track title -- on *every* step, so "turn it up three notches" became a wall of chatter. That was the app re-saving the station's remembered volume by rebuilding the whole favorites list underneath you. It now saves the new level quietly, so you hear just "Radio volume 60", "Radio volume 70". (#1154)
- **The Country list in Browse Stations stays put while you arrow through it.** Moving to the Country dropdown and pressing Down used to fire a search that immediately threw your focus into the results list -- so you could never actually arrow down the list of countries. A search now jumps to the results only when you ask for one (the Search button, or pressing Enter in a search box); arrowing through Country or Tag just narrows the list and leaves your focus alone.
- **The Raw stream recording format no longer shows a bitrate.** A raw stream is saved exactly as the station sends it, with no re-encoding, so a "Quality (bitrate)" setting does nothing for it -- it was just a confusing extra control. Recording Settings now hides the bitrate control for the Raw stream format (and for the lossless FLAC and WAV formats) and shows it only for MP3 and OGG, where it actually applies. (#1155)
- **Station search finds more stations by their branding and call sign.** A station listed under a short name -- "103.1 Austin" for "103.1 Austin's 80s Station" -- used to be unfindable if you searched with the dot, and its station id did nothing. iHeart search now ignores punctuation and matches a station's name, its page address, and its numeric id, so "103.1 Austin", "1031 Austin", and "8403" all land on it. (#1156)
- **"Impossible to exit after recording" -- confirmed fixed.** A report of Quill Radio becoming completely unresponsive after a recording, with no way to exit (#1153), was the Alt+F4/Exit freeze that 2.0.1 already fixed: closing while a confirmation prompt is up no longer stacks a second one, and every shutdown step on the way out runs without blocking. This release adds a regression test so that exit path can never silently break again. If you ever meet an unresponsive exit, please send the exact steps.

## Update 2.0.2

Adds concurrent recording, live Sound Enhancements preview, OptiLab broadcast polish, fixes the 2.0.1 channel mode, and adds two favorites features people asked for:

- **Sound Enhancements preview live, and every setting is per-station.** You asked for the sliders to work while something is playing -- they do now. Move any control in Playback > Sound Enhancements (the EQ sliders, Even Out Volume, Channel mode, Night mode, or the new broadcast polish) and you hear it on what's playing immediately, no OK required: live and uninterrupted on the default engine, and on the Windows Media engine it reconnects once the change settles. **OK** keeps and saves it; **Cancel** or **Escape** puts everything back exactly as it was when you opened the dialog. And -- as you also asked -- *every* setting in that dialog is now remembered per station as well as shared, not just the EQ and channel mode: open it while a favorite is playing to give that station its own night mode or broadcast polish too, or open it with nothing playing to set the shared default every other station follows.
- **Broadcast polish (OptiLab).** Sound Enhancements gained a one-touch broadcast-polish section: pick a **mode** -- **Podcast Leveler** for speech, **Stream Polish** for music, or **Smooth Limiter** for clean peak control -- set an optional **Input** trim (0 dB by default) and an **Auto-Adapt** amount, and there's a checkbox to bypass it while keeping your chosen mode. It levels, adds density, and limits, so a run of stations at wildly different loudness sits at a steadier, fuller level -- especially nice for talk streams and unattended recordings. This is adapted, with thanks and full credit, from **OptiLab Core by dgl1984** ([github.com/dgl1984/optilab](https://github.com/dgl1984/optilab), Apache-2.0). OptiLab itself is a GUI-only plugin (JSFX/CLAP/Winamp DSP) with no library to call, so rather than embedding its Windows-only binary we reproduce the shape of its three modes as ffmpeg filter chains that ride the same pipeline as the rest of Sound Enhancements -- so it previews live on the default engine, applies to recordings, and works cross-platform. It's a faithful adaptation, not a bit-for-bit port of OptiLab's custom DSP; if you want the exact plugin, grab it from dgl1984's repository.
- **Record as many stations at once as you want.** Until now the recorder held exactly one recording at a time. If you scheduled two shows that overlapped, the first one won and the rest were quietly dropped; and Record Station refused to start while anything else was recording. That limit is gone. Every recording now runs on its own -- overlapping scheduled shows all record, and you can start one Record Station capture after another while listening to something else entirely. Each recording is fully independent: its own connection, its own reconnect-on-a-hiccup handling, its own crash-resume marker, so one recording dropping, finishing, or being stopped never disturbs the others.
  - **A limit if you want one.** Recording Settings gained **Maximum simultaneous recordings**. Zero means unlimited -- the default, so everything you ask for records. Set a number to cap it on a slower machine or a metered connection; when the cap is reached, a scheduled recording is held pending and retried within its window instead of being lost.
  - **Record Now follows what you're listening to.** Press Record Now and it records the station you're on; press it again on that same station and it stops *that* recording. A background recording of a different station is never stopped by accident -- to stop one of those, use the Recordings window.
  - **Stop Recording, and Stop All Recordings.** The Recordings window's **Stop Recording** button stops the one recording you've selected. **Stop All Recordings** -- in the Record menu, the tray/status menu, and as a button that appears in the Recordings window when two or more are running -- stops every recording at once.
  - **The Recordings window shows them all.** Each recording in progress is its own row with its own live elapsed time, and the status bar and tray tooltip read "(2 recording)" when several are running together.
  - **Crash-resume covers every one.** Each recording writes its own resume marker, so after an unexpected close Quill Radio offers to resume all of them -- a single prompt for one interrupted recording, and one batched "Resume all?" prompt when there were several, rather than a stack of dialogs to click through.
- **Channel mode Left/Right now plays in one ear only.** In 2.0.1, choosing "Left only" or "Right only" accidentally played the audio in *both* ears. It now sends the whole stereo mix -- nothing lost -- to just the one ear you chose and silences the other, so you really can keep the radio in one ear while your screen reader uses the other. Mono and Stereo are unchanged.
- **Sort your favorites: Ascending, Descending, or Unsorted.** Preferences (Ctrl+,) gained a **Favorites sort order** that orders your folders and stations by name (Ascending A to Z, or Descending Z to A) and re-sorts the moment you add one. **Unsorted** keeps the hand-arranged order you build with Move Up/Down -- and that order is never thrown away, so you can flip back to it any time. Any folder can carry its own sort from its context menu, overriding the default just for that folder's stations.
- **Import stations from an M3U/M3U8 playlist.** Station > **Import Stations from Playlist...** reads a playlist file into a folder you pick -- an existing one, or a brand-new path you type at any depth like `News/Local` -- and, when some of the stations are already favorites, asks whether to skip those or import everything. Station names come from the playlist's `#EXTINF` lines; a bare URL is named after its host.

## Update 2.0.1

A fast follow-up from the first round of live feedback, folded into this same release:

- **A recording no longer stops after a minute on a transient hiccup.** With "continue recording while re-establishing a connection" on, a momentary `403 Forbidden` (an expiring or rotating stream token) or other brief 4xx used to be treated as a permanent failure, so the recording ended instead of reconnecting. Now only genuinely-terminal outcomes -- a full disk, or an HTTP 404/410/451 that means the stream is truly gone -- stop a recording; a transient drop reconnects as it should, and an error ffmpeg already recovered from can no longer strand a later, unrelated drop.
- **It is now obvious when recording has begun.** Pressing Record Now (or scheduling Record Station) announces "Recording started: <station>" -- a clear spoken confirmation, not the old label-like "Recording <station>".
- **Review and copy What's Playing.** A new **What's Playing - Review and Copy...** command opens a small accessible dialog with the current title and artist in a read-only, selectable field you can arrow through character by character to catch the spelling -- with a Copy button to paste it into a lyrics or store search. A separate **Copy What's Playing** command copies it straight to the clipboard.
- **Channel mode: Stereo, Mono, Left only, or Right only.** The old "Combine channels into mono" checkbox in Sound Enhancements is now a Channel mode choice. Left or Right sends the whole stereo mix (nothing lost) to just that one ear and silences the other, so you can listen to the radio in one ear while your screen reader uses the other. It works as your shared default and, like the equalizer, as a per-station setting that's remembered for that station.
- **Turn a recording down while it plays back.** Ctrl+Up and Ctrl+Down now change the volume from inside the Recordings window, the same as they do for live radio.

## The headline: recordings you can trust

### A recording in progress now survives a restart -- and Quill Radio asks before resuming

This is the one that hurt. You set a recording going, the app quits or crashes (or Windows does), and the recording is just gone -- the FFmpeg process it had started keeps writing to a temp file nobody would ever find.

Quill Radio now remembers an in-progress recording. It writes a small marker when a recording starts and clears it on a clean stop, so a crash leaves a breadcrumb. On the next launch it first tidies the temp folder -- any finished orphan file is moved into your recordings folder where you'll actually find it, while a file still being written is left untouched -- and then, if a recording was in progress and is still within a 10-minute grace window, it asks you, once, in a proper accessible dialog:

> A recording of WQXR was in progress until 9:00 AM. Resume it for the remaining 12 minute(s)?

**Resume** (Enter) restarts the recording for the remaining minutes only -- not a fresh full duration. **Skip** (Escape) leaves it as it is. A **Don't ask me again** checkbox remembers your choice -- always resume, or never ask -- and you can change it later in Preferences. Nothing happens when nothing was in progress, and a marker file that has gone corrupt is thrown away rather than driving a bogus resume.

### Scheduled recordings fire reliably throughout their window, not just at the exact minute

The scheduler used to match the exact start minute. So a recording set for 8:00 that Quill Radio only reached at 8:01 -- a slow launch, a brief stall, the tray icon taking a moment -- silently never fired, and a start that failed still burned the whole occurrence for the day.

The scheduler now treats an entry as due from its start time through the end of its duration, so a late arrival starts with the remaining minutes and catch-up on launch is free. Last-fired is stamped only on a successful start (a failure retries on the next poll while the window is still open), one-time entries auto-disable once they've fired, and when two schedules are due in the same minute while the recorder is busy, the second is held and announced instead of being burned. The scheduler thread itself is now lock-guarded and wrapped so it can no longer die silently.

### The Recordings list stops flickering and keeps your place

The Recordings list used to rebuild itself on every refresh, snapping a screen reader back to the top and losing whatever you'd selected. It now updates rows in place, keyed by file path: a no-op when nothing has changed, and when something has, your selection, focus, and scroll position are all preserved instead of the list rebuilding under you mid-read.

The counts are honest now, too. The active recording is counted from the recorder itself, so a recording writing to a temp folder is no longer invisible in the list; a firing schedule is no longer double-counted; and completed one-time entries drop out of the scheduled count. The active row shows a live elapsed time, scheduled entries show their zone-labeled times, and the tray tooltip carries "(recording)" while a capture is running.

### Recordings harden against dropped connections, dead streams, and a crashed host

Four pipeline fixes that together make a long unattended recording far more likely to come out whole.

- **A reconnect records only the remaining time**, not a fresh full duration. A 60-minute show that drops at minute 50 records a roughly 10-minute continuation, not another 60.
- **Filenames are never silently overwritten.** The old unconditional overwrite is gone; a filename pattern that would produce the same name twice gets `" (2)"`, `" (3)"` appended instead of clobbering an earlier recording, and continuation parts keep the original start timestamp in their name so they group together.
- **A drop is classified before any reconnect attempt is spent.** A *fatal* failure -- your disk is full, or the server took the stream down with an HTTP 4xx such as a 404 or 410 -- stops trying, because the stream is gone and reconnecting would only spam continuation files. A *transient* drop (a network hiccup or a 5xx) is retried as before.
- **A crashed host no longer strands a recording.** On Windows the FFmpeg child is tied to Quill Radio's lifetime through a job object, so a crashed or killed Quill Radio takes it down with it instead of leaving a bare FFmpeg writing to your temp folder. And the stop-and-wait fallback moved off the UI thread, so closing the window never hangs on a slow FFmpeg shutdown.

## More stations to find: iHeart and TuneIn now in the search

Browse Stations used to search the community RadioBrowser directory and the free SomaFM directory. 2.0 adds two of the largest directories on the internet -- **iHeart** and **TuneIn** -- blended into the same results list, so a search for a call sign, a city, or a show now reaches far more of the stations people actually ask for. Every result is labeled with where it came from (iHeart, TuneIn, RadioBrowser, SomaFM), and you play it the same way you always have.

Both are keyless and need no account. iHeart is read straight from its public station sitemap -- a two-request directory index -- and a station's real stream is resolved on demand from its own page the moment you play it, never by bulk-fetching thousands of pages. TuneIn goes through RadioTime's open OPML directory (the same service TuneIn's own web player uses): search returns matching stations and the stream address is looked up only for the ones about to play. To keep a single search from turning into dozens of network round trips, iHeart and TuneIn each resolve a small, capped handful of the most relevant matches per search -- enough to add immediately-playable results without slowing the list down -- while RadioBrowser keeps paging as before. A **Refresh** button re-fetches the iHeart directory index (it is cached once per Browse Stations session; TuneIn and RadioBrowser are always live).

With four directories in one list, Browse Stations gained the controls to steer it. A **Source** dropdown lets you narrow the search to just one directory -- All sources, RadioBrowser, iHeart, TuneIn, SomaFM, ACB Media, or Website -- when you already know where a station lives. And the old free-text tag and country boxes are now proper dropdowns: a **Tag/genre** list and a **Country** list, filled in from the directory itself, so you pick "jazz" or "United Kingdom" from a list instead of guessing the exact spelling, and choosing one runs the search right away.

TuneIn also feeds **Find Streams from a Website**: paste a TuneIn station page and Quill Radio resolves its real playable stream, the same on-demand lookup the directory search uses. Find Streams now also recognizes an iHeart or TuneIn page directly rather than handing back a page address that will not play.

Like every other network feature, iHeart and TuneIn are off in Safe Mode, HTTPS-only, and inventoried in QUILL's network-egress audit. This lands in the shared `quill` package (`core/radio/iheart.py`, `core/radio/tunein.py`, `core/radio/directory_search.py`), so QUILL and QUILL Cast gain the same reach.

## Scheduling recordings gained real editing

The Schedule Recording dialog was capture-and-forget: add an entry, and your only other move was to delete it. 2.0 makes the schedule something you can actually manage.

- **Edit** an existing entry -- change its station, time, or duration without deleting and re-adding it.
- **Duplicate** an entry -- a fast way to set up the same show on another day, or a second time slot for the same station.
- **Enable or disable** an entry without losing it -- turn a weekly recording off for a week and back on, instead of deleting and rebuilding it. A disabled entry reads as "(disabled)" in the list and simply does not fire.
- **Type the time your way** -- "7:30 PM" or "19:30", whichever you think in; both are understood.
- **Pin an entry to a time zone** -- each schedule entry carries its own zone (defaulting to your local time), so a show quoted in Eastern records at the right moment wherever you are, and the list shows each entry's time with its zone.

## What's Playing reaches more stations

When a station will not answer the usual title request -- and after Quill Radio has already tried the playback engine's own title channel -- it now takes one more step: it reads the station's own public "now playing" status page (the Icecast or SHOUTcast status endpoint the stream's own server publishes) and pulls the current title from there. It only ever talks to the same server you are already listening to, and it is off in Safe Mode. The practical result is a real "Now playing" on a batch of stations that used to answer with silence.

## For troubleshooting: verbose logging and a log folder you choose

Two additions for when something needs diagnosing. Preferences (Ctrl+,) gained a **Verbose logging** checkbox that turns on detailed debug logging live, without a restart, and a **Log folder** setting so you can point the log somewhere easy to find (and hand to a bug report). Recording problems now capture the recorder's own error output into that log as well, so a failed capture leaves a trail instead of a mystery.

## Built on the 1.1.0 base

2.0 stands on everything 1.1.0 delivered, and none of it changes:

- **The mpv playback engine**, used automatically, with the classic Windows Media engine one Preferences setting away.
- **Every stream format in real-world use** -- MP3, AAC and HE-AAC (AAC+), Ogg Vorbis, Opus, FLAC streams, and HLS (m3u8).
- **A second sound card for the radio**, live pause and rewind of the stream, and **Volume Boost**.
- **Sound Enhancements** as a full listening toolkit -- three-band EQ, compressor, mono downmix, night mode, per-station memories -- applying live on the mpv engine.
- **Alt+F4 to the tray**, automatic update checks, Preferences, the unified station finder, and file logging.

See `release-notes-1.0.md` for the 1.0 and 1.1.0 story in full, and `CHANGELOG.md` for the complete versioned history.

## Known notes for this release

- Releases are not yet code-signed: Windows SmartScreen may warn on first run. Choose More info, then Run anyway. Signing is planned.

## Not a fork -- a guarantee

Quill Radio runs the exact same radio feature code as QUILL, from the same upstream package. The recordings overhaul in this release lands once, in the shared `quill` package, and reaches QUILL, Quill Radio, and QUILL Cast together. This repository carries only the wrapper, the installer, the icon, and these docs.
