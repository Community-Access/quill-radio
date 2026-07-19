# Quill Radio User Guide

Version 2.0

Quill Radio is internet radio the way a screen reader user would design it: a small window whose favorites tree has focus the instant it opens, menus that say everything they do, spoken feedback for every action, and a tray icon so the music keeps playing while you work. It runs the exact same radio code as QUILL itself and shares its data, so nothing you set up here is ever stranded.

## Installing

Two flavors, both fully bundled (ffmpeg included, nothing ever downloads):

- **The installer** (`Quill-Radio-Setup-2.0.0.exe`) -- its own folder, Start Menu entry, uninstaller. Your data lives in the shared Quill store in your Windows profile.
- **The portable zip** (`Quill-Radio-Portable-2.0.0.zip`) -- extract anywhere, even a USB stick, and run `QuillRadio\QuillRadio.exe`. Its `data` folder keeps your favorites, history, and settings inside the app folder, so the whole radio travels with you.

Windows SmartScreen may warn on first run because this release is not code-signed; choose "More info" then "Run anyway". The build is exactly what this repository's source produces.

## Getting started

Launch Quill Radio from the Start Menu (or the portable folder's `QuillRadio.exe`). The window opens with keyboard focus on your **Favorite stations** tree.

- No favorites yet? Press Alt+S for the Station menu, then **Browse Stations...** to search thousands of stations by name, genre, country, or language, listen before you commit, and add the keepers to your favorites. The **ACB Media** submenu is also right there -- the whole ACB stream directory, playable without any setup.
- With favorites: arrow to a station and press **Enter**. That is the whole loop.
- Want the radio on the moment the app opens? Check **Station > Resume Last Station on Launch** once, and Quill Radio becomes an appliance: launch it, and your station is already playing.

Everything Quill Radio announces goes through the same announcement engine QUILL uses, so it speaks through your screen reader (JAWS, NVDA, Narrator) without stealing focus.

## The main window

Tab order: the now-playing line, the favorites tree, then four buttons.

- **Now playing** (read-only text): what is on right now; also mirrored in the status bar and the Playback menu.
- **Favorite stations** (tree): the same nested folder structure you build in the Favorites Manager, right on the main page. Enter plays a station, Delete removes it (with confirmation), F2 renames a station or folder, and Shift+F10 opens the full context menu -- Play/Stop, Rename, Move to Folder, Remove, New Folder, and Manage Favorites. Your custom names are used everywhere.
- Buttons: **Play** (it becomes **Stop** while connecting or playing -- one transport control, never a dead button), **Add to Favorites** (it becomes **Remove from Favorites** when the playing station is already saved -- perfect for keeping something you found in ACB Media or Recently Played), **Record**, **Browse Stations...**

## Menus

### Station (Alt+S)

- **Browse Stations...** -- the full station browser: search across four directories at once -- **RadioBrowser**, **SomaFM**, **iHeart**, and **TuneIn** -- blended into one results list, test-play, favorite. Every result is labeled with the directory it came from ("via iHeart", "via TuneIn"). RadioBrowser shows up to 200 stations at once, most-listened first; when there are still more, a **More Stations** button loads the next page and puts your cursor on the first newly added station. iHeart and TuneIn add a small set of their most relevant, immediately-playable matches to each search (each iHeart/TuneIn result's real stream is looked up on demand, so they are capped per search to keep one search from becoming dozens of network requests).
  - **Source** -- a dropdown to narrow the search to one directory (All sources, RadioBrowser, iHeart, TuneIn, SomaFM, ACB Media, or Website) when you already know where a station lives.
  - **Tag/genre** and **Country** -- these are now proper dropdown lists, filled in from the directory itself, so you pick "jazz" or "United Kingdom" from a list instead of typing the exact spelling; choosing one runs the search right away.
  - **Refresh** -- re-fetches the iHeart station directory. iHeart's directory index is cached once per Browse Stations session (TuneIn and RadioBrowser are always live), so use Refresh if you want the very latest iHeart listing.
  - The status line tells you when more can be loaded and suggests adding a tag or country to narrow a very broad search. Search is disabled in Safe Mode.
- **Add Custom Station...** -- paste any stream URL and name it yourself.
- **When a station won't play, Quill Radio tries to fix it for you.** Some stations are listed in the directory but their stream address is dead -- often because the real stream is behind a player on the station's website. Instead of just failing, Quill Radio works down a short ladder: it re-resolves the address (for StreamTheWorld-style players that moved servers), refreshes the address from the directory, and -- if the setting is on -- scans the station's own website, following a "Listen Live"/"Play"/"Tune In" link into the player and recognizing Triton players there. If it finds one clear stream it plays it and remembers it for that favorite; if it finds several it tells you the count and you can open Find Streams to choose. The website step is the "Recover failed streams from the station's website" checkbox in Station > Preferences (Ctrl+,), on by default and off in Safe Mode. It only tries once per station per session.
- **Find Streams from a Website...** -- give it a website address; it scans that one page for stream links, with a Test button that toggles to Stop Test while a candidate plays. This now also works for many stations whose "Listen Live" button is a modern JavaScript player (Triton Digital / StreamTheWorld, including the whole `player.listenlive.co` network -- for example `player.listenlive.co/34461`). Those players build their stream address in code, so it is not written anywhere in the page for a scanner to read; Quill Radio recognizes the player, reads the station's call letters from the page, and looks the real stream up through the station provider's own public address service -- no browser, no guessing. Both the MP3 and the AAC stream are offered when a station publishes both. It also recognizes an **iHeart** or **TuneIn** station page pasted directly and resolves its real playable stream through that directory, instead of handing back a page address that will not play. If a page is not one of these players or directories, or does not name its station, the scan simply behaves as before.
- **Manage Favorites...** -- the favorites, made organizable. See "The Favorites Manager" below.
- **New Folder...** (Ctrl+Shift+E) -- create a folder right where you want it: pick the location (top level or inside any existing folder), then name it. The folder exists immediately, ready for Move to Folder.
- **Play Last Station** (Ctrl+L) -- resume whatever you last had on, one keystroke, no navigation.
- **Recently Played** (submenu) -- your last fifteen stations, newest first, playable inline.
- **Favorite Stations** (submenu) -- every favorite, nested by your folders, playable inline.
- **ACB Media** (submenu) -- ACB's whole stream directory, playable inline.
- **Resume Last Station on Launch** (check item) -- the appliance switch.
- **Preferences...** (Ctrl+,) -- Resume Last Station on Launch, automatic Check for Updates, Announce dialog transitions (off by default -- turn on for more spoken detail around every dialog), When closing the window (Ask every time / Exit / Minimize to Tray -- governs the titlebar X, Station > Exit, and by default Alt+F4 too), **Alt+F4 minimizes to the system tray** (off by default: turn it on and Alt+F4 alone tucks the radio into the tray, still playing, while X and Exit keep the setting above -- the reflexive close stops meaning quit), **Playback engine** (Automatic -- recommended -- uses the bundled mpv engine, which powers the output device choice, pausing and rewinding live radio, Volume Boost, and stations in more formats; "Windows Media (classic)" is exactly the pre-1.1 behavior if you ever want it back), and **Radio output device** (route just the radio to a second sound card or USB headset -- your screen reader and Quill Radio's own sounds stay on the system default device; an unplugged device is remembered, not reset, and if it can't be used the radio plays through the default and says so). Every setting takes effect the moment you save -- switching engine or device mid-song reconnects the station right where it matters: on the new engine or device. Preferences also carries two troubleshooting settings: **Verbose logging** (a debug-mode checkbox that turns on detailed logging live, no restart, for when you need to diagnose something or attach detail to a bug report) and **Log folder** (choose where the log is written so it's easy to find; a failed recording captures the recorder's own error output into it as well).
- **Send to Tray** (Ctrl+W) -- hide the window; playback continues from the notification area.
- **Exit** -- quit Quill Radio. Closing the window this way, from the titlebar X, or with Alt+F4 all ask first (unless you've told it not to, or set a fixed answer in Preferences): Exit, Minimize to Tray, or Cancel, with a "Don't ask me again" checkbox. Recording in progress is called out in the message, since exiting stops it. And if "Alt+F4 minimizes to the system tray" is on in Preferences, Alt+F4 skips all of this and simply tucks the radio into the tray, still playing.

### Playback (Alt+P)

- A live (disabled) now-playing line at the top, so the menu itself tells you what is on.
- **Play / Stop** (Ctrl+P) -- one transport item that reads Play when idle and Stop while connecting or playing, exactly like the panel button.
- **Mute/Unmute** (Ctrl+M), **Volume Up** (Ctrl+Up), **Volume Down** (Ctrl+Down). Each favorite remembers the volume you set while it plays and gets it back the next time it starts -- stations are mastered wildly differently, and you should only have to fix that once per station.
- **Volume Boost** (Ctrl+Shift+B, check item) -- amplifies up to 50% past full volume for stations that just broadcast quiet. Your 0-100 volume scale, per-station volume memories, and mute all behave exactly as before; the boost is applied on top. Needs the mpv playback engine (the default -- see Preferences below).
- **Rewind 30 Seconds** (Ctrl+Shift+Left), **Forward 30 Seconds** (Ctrl+Shift+Right), **Back to Live** (Ctrl+Shift+L) -- live radio you can move around in. Quill Radio keeps a rolling buffer of the stream (roughly 45 minutes at typical bitrates): pause with Play/Stop and resume where you left off, jump back to catch a missed sentence, then work your way forward or leap straight back to live. Every move announces how far behind live you are. Needs the mpv playback engine.
- **What's Playing?** (Ctrl+T) -- speaks the current track or show title straight from the stream's own metadata. When a station sends messy broadcast metadata (a string of catalog codes rather than a clean "Artist - Title"), Quill Radio finds the title and artist in it and reads just those. And when a station answers with nothing at all -- no metadata, and the playback engine's own title channel is empty too (common on HLS) -- Quill Radio takes one more step: it reads the current title from the stream server's own public "now playing" status page (the Icecast or SHOUTcast status endpoint). It only ever asks the same server you are already listening to, and it is off in Safe Mode -- so a batch of stations that used to answer with silence now report a real title. You control the wording in Station > Preferences (Ctrl+,) with a small template: `{title}` and `{artist}` tokens, `[square brackets]` around optional wording that disappears when a field is empty (the default `{title}[ by {artist}]` drops the " by" when there's no artist), and `{raw}` for the stream's exact original text. Leave it blank to restore the default.
- **What's Playing - Review and Copy...** -- opens a small window with the current title and artist in a read-only, selectable field you can arrow through **character by character** to catch an exact spelling, with a **Copy** button to put it on the clipboard (handy for looking up lyrics or buying a track). A separate **Copy What's Playing** command (in the Command Palette) copies it straight to the clipboard without opening the window. Press What's Playing first so there's a title to review.
- **Announce Track Titles** (check item) -- when on, title changes are announced as they happen. Off by default.
- **Sleep Timer...** -- fade out and stop after a set time, restoring your volume.
- **Wake-Up Timer...** -- the sleep timer's twin: pick a favorite, a time, once or every day, and the station starts playing by itself. Quill Radio must be running (the tray counts).
- **Sound Enhancements...** -- a three-band equalizer (Bass, Mid, Treble sliders, -12 to +12 dB each, freely adjustable), a compressor ("Even Out Volume", boosts quiet passages and tames loud ones), a **Channel mode** choice (Stereo, Mono, Left only, Right only) and **Night mode**. Channel mode routes the audio for accessibility: **Mono** blends both stereo channels into one, so a station that hard-pans a voice to one side never disappears with single-sided hearing or a single earbud; **Left only** or **Right only** sends just that one channel to both ears, so you can listen to the radio in one ear while your screen reader (or anything else) uses the other. **Night mode** evens loudness in real time by lifting quiet passages -- the complement to Even Out Volume taming loud ones; ideal for low-volume late-night listening. A "Quick preset" combo box (Flat, Bass Boost, Voice Clarity, Podcast, Small Speakers, Late Night) sets all three sliders at once as a starting point -- move any slider afterward and it becomes Custom. Off by default. On the mpv playback engine (the default), changes apply **live, with no interruption at all**; on the Windows Media engine they filter through FFmpeg (needs Help > Get FFmpeg...) and reconnect on OK -- instant, since a live stream has no position to lose. The EQ, compressor, and **Channel mode** are **remembered per station**: open the dialog while a favorite is playing to set that station's own sound (including sending just that station to one ear); with nothing playing (or a non-favorite on), you're setting the shared default every other station follows. Night mode is always shared -- it describes your evening, not a station.

### Record (Alt+R)

- **Record Now / Stop Recording** -- capture the station you are listening to. When a capture begins, Quill Radio announces "Recording started" with the station name, so it is always clear the command took effect.
- **Record Station...** -- record a *different* station for a set number of minutes while you listen to something else (or to nothing). The recorder is its own process; it never needed the player.
- **Schedule Recording...** -- record a show later, once, daily, or weekly, even from the tray. Pick a favorite from the list and its name and stream fill in for you (both stay editable for one-off streams). Enter the time however you think of it -- "7:30 PM" or "19:30", both are understood -- and pin each entry to its own **time zone** (defaulting to your local time), so a show quoted in another zone records at the right moment and the list shows each entry's time with its zone. The schedule is something you manage, not just add to:
  - **Edit** -- change a selected entry's station, time, duration, or repeat without deleting and re-adding it.
  - **Duplicate** -- copy a selected entry as a starting point for another day or a second time slot.
  - **Enable / disable** -- turn an entry off without losing it; a disabled entry reads "(disabled)" in the list and does not fire, and you can turn it back on any time.
  - **Remove** names the schedule it will delete and dims when none is selected; the Delete key and a context menu work on the list too.
  A schedule is due from its start time through the end of its duration, so if Quill Radio reaches a few seconds late it still starts with the remaining minutes, and on launch it catches up anything whose window is still open. (Quill Radio has to be running for a scheduled recording to fire -- the tray icon counts -- so a show whose whole window passed while Quill Radio was closed is simply missed, and the next launch tells you, naming up to three and collapsing the rest to a count.)
- **Recordings...** -- everything you have recorded, live. See "The Recordings list" below.
- **Recording Settings...** -- format (MP3, OGG, FLAC, WAV, or **Raw stream** -- see below), bitrate, destination folder, filename pattern, a maximum-length safety cap, the **If the connection drops** section (reconnect on/off, how many attempts, and how many seconds between them), and **Apply Sound Enhancements to recordings** -- off by default, so recordings stay an unfiltered archival copy even with Sound Enhancements on for live listening; turn it on to record the filtered (EQ/compressor) audio instead, for every recording method (Record Now, Record Station, and scheduled recordings alike).

### Raw stream recording (lossless capture)

The **Raw stream -- exactly as sent, no re-encoding (lossless)** format in Recording Settings saves a recording that is bit-for-bit identical to what the station broadcasts. The MP3/OGG/FLAC/WAV formats decode the incoming audio and re-encode it to your chosen format; the raw option skips all of that and copies the station's own audio packets straight to disk, untouched. Choose it when you want the cleanest possible source to edit or convert yourself, with no quality lost to a second encoding.

Quill Radio picks the file type for you from the stream's own format: an MP3 stream is saved as a `.mp3` file, AAC as `.aac`, Ogg Vorbis as `.ogg`, Opus as `.opus`, FLAC as `.flac`. Anything unusual is saved into a Matroska `.mka` file, a container that holds any kind of audio losslessly and opens in players like VLC. Because nothing is being re-encoded, the Bitrate setting and Apply Sound Enhancements have no effect on a raw recording and are simply ignored. If a recording is interrupted and continues into a "(part 2)" file, that part keeps the same file type as the recording it continues.

### Help (Alt+H)

- **Command Palette...** (Ctrl+Shift+P) -- every Quill Radio command in one searchable list.
- **Redeem Unlock Code...** -- enter a signed code for a pre-release capability. Verified entirely on your machine; nothing is transmitted; one code counts for QUILL, Quill Radio, and QUILL Cast together.
- **Check for Updates...** -- compares your version with the newest release, downloads the right artifact for your flavor directly (the installer for an installed copy, the portable zip for a portable one) with spoken progress, then offers Install now or Open folder. Already up to date shows a dialog too, not just a spoken announcement. Quill Radio also runs this check quietly once a day when it launches -- silent unless it actually finds something, and Station > Preferences (Ctrl+,) turns it off if you'd rather check manually only.
- **Get FFmpeg...** -- a safety net: FFmpeg ships inside Quill Radio, but if it ever goes missing this downloads the official build so recording works again.
- **User Guide** / **Release Notes** / **Product Requirements...** -- this guide, the version history, and the product requirements document, each opened right in your browser.
- **Report a Bug...** -- files an issue directly from the app (no GitHub account needed), stamped "Quill Radio" with this app's own version so we know exactly what you were running; falls back to the online support form if anything goes wrong.
- **About Quill Radio** -- version, sync statement, project address.

## The Favorites Manager

Station > Manage Favorites... is a full organizer, keyboard-first:

- **Search favorites** filters live across names (including your custom names), countries, languages, tags, and folder names; results flatten into one arrow-key list with each station's folder spoken in its label.
- **Folders of any depth.** Create one with **New Folder...** (Ctrl+Shift+E) -- pick its location, name it, and it exists immediately, even before a station lives in it. Or just file a station under "News/Morning" and the path springs into being. Rename a folder (F2) and its subfolders come along; delete one and its stations simply step out to the top level -- nothing is ever deleted with a folder.
- **Reordering.** Move Up / Move Down within a folder; for long hops, **Mark for Move**, select the destination, then **Move Above** or **Move Below** -- the moved station joins the destination's folder.
- **Rename** (F2 on a station) gives it your own display name everywhere; blank restores the directory's name.
- Enter plays (the Play button reads Stop while that station is on), Delete removes (with confirmation), Shift+F10 opens every action on the selected item. The main-page tree offers the same actions, so the Manager is for the heavy lifting, not a required stop.

## The Recordings list

Record > Recordings... shows the whole recording life cycle in one place. The list updates rows in place keyed by file path, so it is a no-op when nothing has changed; when something has, your selection, focus, and scroll position are preserved instead of the list rebuilding under you mid-read:

- The recording being written right now -- status **Recording**, its size growing as you watch, with a live elapsed time. It is counted from the recorder itself, so a recording still being written to the temp folder is always visible here, never invisible until it lands.
- Every finished file, newest first -- status **Recorded**, with size and date.
- Upcoming scheduled recordings -- status **Scheduled**, with their zone-labeled times.

The recording and scheduled counts are accurate: a schedule that is currently firing is not double-counted, and a completed one-time schedule drops out of the scheduled count rather than lingering.

Actions: **Play** (through the app's own player; it reads **Stop** while that recording is playing), **Stop Recording**, **Open in Folder**, **Remove** (Delete key, with confirmation), **Refresh**. While a recording plays back, **Ctrl+Up** and **Ctrl+Down** change its volume right here, the same as they do for live radio. The tray tooltip carries "(recording)" while a recording is active.

### If the internet hiccups during a recording

ffmpeg first rides out short gaps itself (the reconnect settings in Recording Settings). If the connection truly dies, Quill Radio waits and resumes into a numbered **part file**, announcing each attempt. Two things keep that tidy:

- A continuation records only the *remaining* time to the original scheduled end, not a fresh full duration -- a 60-minute show that drops at minute 50 records a ~10 minute continuation, not another 60.
- A drop is classified before any reconnect attempt is spent, and only a genuinely-terminal failure gives up: your disk is full, or the server returned an HTTP 404, 410, or 451 that means the stream is truly gone. Everything else -- a network hiccup, a 5xx, or a momentary 403 Forbidden from an expiring or rotating stream token -- is transient and reconnects. (A transient error ffmpeg has already recovered from can no longer be mistaken for a fatal one when the stream later drops for an unrelated reason, so a recording is far less likely to stop short.)

Output filenames are never silently overwritten: a pattern that produces the same name twice gets `" (2)"`, `" (3)"` appended instead of clobbering the earlier file, and part files keep the original start timestamp in their name so they group together. And on Windows, the FFmpeg child is tied to Quill Radio's lifetime through a job object, so a crashed or killed Quill Radio takes it down rather than stranding a bare recording writing to your temp folder.

### If a recording was in progress when Quill Radio quit or crashed

A recording used to be lost the moment Quill Radio quit or crashed. It now remembers an in-progress recording and offers to pick it back up. On the next launch it first tidies the temp folder (any finished orphan file is moved to your recordings folder; a file still being written is left untouched), then, if a recording was in progress and is still within a 10-minute grace window, asks once in an accessible dialog:

> A recording of WQXR was in progress until 9:00 AM. Resume it for the remaining 12 minute(s)?

**Resume** (Enter) restarts the recording for the remaining minutes only. **Skip** (Escape) leaves it as it is. A **Don't ask me again** checkbox remembers your choice -- always resume, or never ask -- changeable later in Preferences. Nothing happens when nothing was in progress, and a corrupt marker is discarded rather than driving a bogus resume.

## Hardware media keys

If your keyboard has media keys, Play/Pause and Stop control Quill Radio system-wide while it runs -- even from the tray. Keys another app already owns are left alone.

## The system tray

Closing the window keeps Quill Radio available in the notification area with its own icon, announced by name. Right-click (or keyboard-invoke) the tray icon for: Show, the live now-playing line, a single **Play/Stop** item whose label is always current, Mute/Unmute, your **Favorite Stations** (nested by folder) and **Recently Played** submenus, Record Now/Stop Recording, Schedule Recording, Recording Settings, Browse Stations, and Exit. Double-click brings the window back.

## Sharing data with QUILL

Quill Radio reads and writes the same data store as QUILL and QUILL Cast (`%APPDATA%\Quill`): favorites (folders, custom names, and per-station volumes included), history, recordings, schedules, timers, and settings. A station you favorite here is a favorite in QUILL's radio; the wake-up timer you set in QUILL fires here. Uninstalling Quill Radio never deletes that shared data.

## Dependencies, honestly stated

- **Playback** uses the bundled **mpv** engine (`tools\mpv` inside the install folder -- license texts and source note ship right next to it) with the Windows Media Player engine built into Windows as automatic fallback and as the "classic" choice in Preferences. Nothing to install, nothing downloads at runtime. Between the two engines, effectively every stream format in real-world use plays: **MP3, AAC and HE-AAC (AAC+), Ogg Vorbis, Opus, FLAC streams, and HLS (m3u8)** -- and a station one engine can't open is quietly retried on the other before you ever hear an error.
- **Recording**, **Sound Enhancements** on the classic engine, and (when "Apply Sound Enhancements to recordings" is on) recording's own filtering all use **ffmpeg**, which the installer bundles at `tools\ffmpeg` inside the install folder. Nothing downloads at runtime. On the classic engine, Sound Enhancements plays through a small local relay (ffmpeg filters the stream, a loopback-only web server on your own machine hands the filtered audio to the player) -- nothing about it is reachable off your computer; on the mpv engine the same filters run inside the player itself, no relay at all.
- **Station search** talks to four keyless, account-free directories, blended into one results list: the community **RadioBrowser** directory, the free **SomaFM** directory, **iHeart** (read from its public station sitemap, `www.iheart.com`, with each chosen station's real stream resolved on demand from its own page), and **TuneIn** (through RadioTime's open OPML directory, `opml.radiotime.com` -- the same service TuneIn's own web player uses). **Find Streams** fetches only the one page you type (following its "Listen Live" link one level and, if it's a Triton/StreamTheWorld player or an iHeart/TuneIn page, one lookup to that provider's own public address service); **stream recovery** does the same lookups against a failing station's own website only when a stream won't play (and only if you leave the setting on); **What's Playing** reads metadata from the stream you are already playing, and as a last resort reads the current title from that same stream server's own public status page (its Icecast or SHOUTcast now-playing endpoint -- the same host, never a third party). All network features are off in Safe Mode. No other network calls exist, and every one of them is inventoried in QUILL's network-egress audit.
- The **ACB Media** directory is bundled -- no network needed to browse it.

## Keyboard reference

| Action | Key |
| --- | --- |
| Play / Stop | Ctrl+P |
| Play Last Station | Ctrl+L |
| Mute / Unmute | Ctrl+M |
| Volume up / down | Ctrl+Up / Ctrl+Down |
| Volume Boost | Ctrl+Shift+B |
| Rewind / Forward 30 seconds | Ctrl+Shift+Left / Ctrl+Shift+Right |
| Back to Live | Ctrl+Shift+L |
| What's Playing? | Ctrl+T |
| Send to tray | Ctrl+W |
| Preferences | Ctrl+, |
| New Folder | Ctrl+Shift+E |
| Command Palette | Ctrl+Shift+P |
| Play selected favorite | Enter (in the list) |
| Rename (manager) | F2 |
| Remove (manager / recordings) | Delete |
| Station menu | Alt+S |
| Playback menu | Alt+P |
| Record menu | Alt+R |
| Help menu | Alt+H |

These keys belong to Quill Radio's own menus and are kept separate from QUILL's keymap, so nothing here collides with editor shortcuts.

## Troubleshooting

- **A station will not play.** Streams move. If the station came from the directory, Quill Radio automatically fetches its current address and retries once; if it still fails, search for it again in Browse Stations, or re-add it as a custom station. (Format problems are largely history as of 1.1.0: the two engines together play MP3, AAC/HE-AAC, Ogg Vorbis, Opus, FLAC, and HLS, and a stream one engine can't open is retried on the other automatically.)
- **No sound but the app says playing.** Check Mute (Ctrl+M), the per-station volume (Ctrl+Up), and the Windows volume mixer entry for Quill Radio.
- **A recording stopped early.** Check Record > Recordings... -- a dropped connection continues into "(part 2)" files when reconnect is on. The maximum-length cap in Recording Settings also ends recordings deliberately.
- **The wake-up timer did not fire.** Quill Radio (or QUILL) must be running at the set time -- the tray counts, a closed app does not. It also never retro-fires: opening the app hours after the set time stays silent until the next occurrence.
- **The tray icon is gone.** Check the taskbar overflow area, or set Quill Radio to "always show" in Windows taskbar settings.
- **Rewind, Volume Boost, or the output device "needs the mpv playback engine."** Preferences (Ctrl+,) > Playback engine is set to Windows Media (classic), or the bundled engine is missing. Set it back to Automatic; these features live in the mpv engine.
- **Playback sounds different since 1.1.0.** It shouldn't -- but if anything about the new engine bothers you, Preferences (Ctrl+,) > Playback engine > "Windows Media (classic)" is exactly the old behavior. Please report what you heard either way (Help > Report a Bug...).
