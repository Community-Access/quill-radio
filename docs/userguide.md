# Quill Radio User Guide

Version 1.0

Quill Radio is internet radio the way a screen reader user would design it: a small window whose favorites tree has focus the instant it opens, menus that say everything they do, spoken feedback for every action, and a tray icon so the music keeps playing while you work. It runs the exact same radio code as QUILL itself and shares its data, so nothing you set up here is ever stranded.

## Installing

Two flavors, both fully bundled (ffmpeg included, nothing ever downloads):

- **The installer** (`Quill-Radio-Setup-1.0.0.exe`) -- its own folder, Start Menu entry, uninstaller. Your data lives in the shared Quill store in your Windows profile.
- **The portable zip** (`Quill-Radio-Portable-1.0.0.zip`) -- extract anywhere, even a USB stick, and run `QuillRadio\QuillRadio.exe`. Its `data` folder keeps your favorites, history, and settings inside the app folder, so the whole radio travels with you.

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

- **Browse Stations...** -- the full station browser: search RadioBrowser's live directory, filter by tag or country, test-play, favorite.
- **Add Custom Station...** -- paste any stream URL and name it yourself.
- **Find Streams from a Website...** -- give it a website address; it scans that one page for stream links, with a Test button that toggles to Stop Test while a candidate plays.
- **Manage Favorites...** -- the favorites, made organizable. See "The Favorites Manager" below.
- **New Folder...** (Ctrl+Shift+E) -- create a folder right where you want it: pick the location (top level or inside any existing folder), then name it. The folder exists immediately, ready for Move to Folder.
- **Play Last Station** (Ctrl+L) -- resume whatever you last had on, one keystroke, no navigation.
- **Recently Played** (submenu) -- your last fifteen stations, newest first, playable inline.
- **Favorite Stations** (submenu) -- every favorite, nested by your folders, playable inline.
- **ACB Media** (submenu) -- ACB's whole stream directory, playable inline.
- **Resume Last Station on Launch** (check item) -- the appliance switch.
- **Preferences...** (Ctrl+,) -- Resume Last Station on Launch, automatic Check for Updates, Announce dialog transitions (off by default -- turn on for more spoken detail around every dialog), and When closing the window (Ask every time / Exit / Minimize to Tray), all in one small dialog. Every setting takes effect the moment you save.
- **Send to Tray** (Ctrl+W) -- hide the window; playback continues from the notification area.
- **Exit** -- quit Quill Radio. Closing the window this way, from the titlebar X, or with Alt+F4 all ask first (unless you've told it not to, or set a fixed answer in Preferences): Exit, Minimize to Tray, or Cancel, with a "Don't ask me again" checkbox. Recording in progress is called out in the message, since exiting stops it.

### Playback (Alt+P)

- A live (disabled) now-playing line at the top, so the menu itself tells you what is on.
- **Play / Stop** (Ctrl+P) -- one transport item that reads Play when idle and Stop while connecting or playing, exactly like the panel button.
- **Mute/Unmute** (Ctrl+M), **Volume Up** (Ctrl+Up), **Volume Down** (Ctrl+Down). Each favorite remembers the volume you set while it plays and gets it back the next time it starts -- stations are mastered wildly differently, and you should only have to fix that once per station.
- **What's Playing?** (Ctrl+T) -- speaks the current track or show title straight from the stream's own metadata.
- **Announce Track Titles** (check item) -- when on, title changes are announced as they happen. Off by default.
- **Sleep Timer...** -- fade out and stop after a set time, restoring your volume.
- **Wake-Up Timer...** -- the sleep timer's twin: pick a favorite, a time, once or every day, and the station starts playing by itself. Quill Radio must be running (the tray counts).
- **Sound Enhancements...** -- a three-band equalizer (Bass, Mid, Treble sliders, -12 to +12 dB each, freely adjustable) plus a compressor ("Even Out Volume", boosts quiet passages and tames loud ones). A "Quick preset" combo box (Flat, Bass Boost, Voice Clarity, Podcast) sets all three sliders at once as a starting point -- move any slider afterward and it becomes Custom. Off by default; turning anything on filters the currently playing station live through FFmpeg (needs Help > Get FFmpeg...) and reconnects on Apply -- there is no playback position to lose on a live stream, so that reconnect is instant. If FFmpeg is missing, playback continues unfiltered and Quill Radio tells you why. **Remembered per station**: open it while a favorite is playing to set that station's own sound; with nothing playing (or a non-favorite on), you're setting the shared default every other station follows.

### Record (Alt+R)

- **Record Now / Stop Recording** -- capture the station you are listening to.
- **Record Station...** -- record a *different* station for a set number of minutes while you listen to something else (or to nothing). The recorder is its own process; it never needed the player.
- **Schedule Recording...** -- record a show later, once, daily, or weekly, even from the tray. Pick a favorite from the list and its name and stream fill in for you (both stay editable for one-off streams); the Remove button names the schedule it will delete and dims when none is selected, and the Delete key and a context menu work on the list.
- **Recordings...** -- everything you have recorded, live. See "The Recordings list" below.
- **Recording Settings...** -- format (MP3, OGG, FLAC, WAV), bitrate, destination folder, filename pattern, a maximum-length safety cap, the **If the connection drops** section (reconnect on/off, how many attempts, and how many seconds between them), and **Apply Sound Enhancements to recordings** -- off by default, so recordings stay an unfiltered archival copy even with Sound Enhancements on for live listening; turn it on to record the filtered (EQ/compressor) audio instead, for every recording method (Record Now, Record Station, and scheduled recordings alike).

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

Record > Recordings... shows the whole recording life cycle in one place, refreshing live:

- The recording being written right now -- status **Recording**, its size growing as you watch.
- Every finished file, newest first -- status **Recorded**, with size and date.
- Upcoming scheduled recordings -- status **Scheduled**, with their times.

Actions: **Play** (through the app's own player; it reads **Stop** while that recording is playing), **Stop Recording**, **Open in Folder**, **Remove** (Delete key, with confirmation), **Refresh**. If the internet hiccups during a recording, ffmpeg first rides it out; if the connection truly dies, Quill Radio waits and resumes into a numbered part file, announcing each attempt -- tune or disable this in Recording Settings.

## Hardware media keys

If your keyboard has media keys, Play/Pause and Stop control Quill Radio system-wide while it runs -- even from the tray. Keys another app already owns are left alone.

## The system tray

Closing the window keeps Quill Radio available in the notification area with its own icon, announced by name. Right-click (or keyboard-invoke) the tray icon for: Show, the live now-playing line, a single **Play/Stop** item whose label is always current, Mute/Unmute, your **Favorite Stations** (nested by folder) and **Recently Played** submenus, Record Now/Stop Recording, Schedule Recording, Recording Settings, Browse Stations, and Exit. Double-click brings the window back.

## Sharing data with QUILL

Quill Radio reads and writes the same data store as QUILL and QUILL Cast (`%APPDATA%\Quill`): favorites (folders, custom names, and per-station volumes included), history, recordings, schedules, timers, and settings. A station you favorite here is a favorite in QUILL's radio; the wake-up timer you set in QUILL fires here. Uninstalling Quill Radio never deletes that shared data.

## Dependencies, honestly stated

- **Playback** uses the Windows Media Player engine built into Windows -- nothing to install.
- **Recording**, **Sound Enhancements**, and (when "Apply Sound Enhancements to recordings" is on) recording's own filtering all use **ffmpeg**, which the installer bundles at `tools\ffmpeg` inside the install folder. Nothing downloads at runtime. Sound Enhancements plays through a small local relay (ffmpeg filters the stream, a loopback-only web server on your own machine hands the filtered audio to the player) -- nothing about it is reachable off your computer.
- **Station search** talks to the community **RadioBrowser** directory and the free, keyless **SomaFM** directory, blended into one results list; **Find Streams** fetches only the one page you type; **What's Playing** reads metadata from the stream you are already playing. No other network calls exist, and every one of them is inventoried in QUILL's network-egress audit.
- The **ACB Media** directory is bundled -- no network needed to browse it.

## Keyboard reference

| Action | Key |
| --- | --- |
| Play / Stop | Ctrl+P |
| Play Last Station | Ctrl+L |
| Mute / Unmute | Ctrl+M |
| Volume up / down | Ctrl+Up / Ctrl+Down |
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

- **A station will not play.** Streams move. If the station came from the directory, Quill Radio automatically fetches its current address and retries once; if it still fails, search for it again in Browse Stations, or re-add it as a custom station.
- **No sound but the app says playing.** Check Mute (Ctrl+M), the per-station volume (Ctrl+Up), and the Windows volume mixer entry for Quill Radio.
- **A recording stopped early.** Check Record > Recordings... -- a dropped connection continues into "(part 2)" files when reconnect is on. The maximum-length cap in Recording Settings also ends recordings deliberately.
- **The wake-up timer did not fire.** Quill Radio (or QUILL) must be running at the set time -- the tray counts, a closed app does not. It also never retro-fires: opening the app hours after the set time stays silent until the next occurrence.
- **The tray icon is gone.** Check the taskbar overflow area, or set Quill Radio to "always show" in Windows taskbar settings.
