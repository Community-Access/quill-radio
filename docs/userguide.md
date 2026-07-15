# Quill Radio User Guide

Version 1.0

Quill Radio is internet radio the way a screen reader user would design it: a small window whose favorites list has focus the instant it opens, menus that say everything they do, spoken feedback for every action, and a tray icon so the music keeps playing while you work. It runs the exact same radio code as QUILL itself and shares its data, so nothing you set up here is ever stranded.

## Getting started

Launch Quill Radio from the Start Menu (or `quill-radio` from a terminal if you installed from source). The window opens with keyboard focus on your **Favorite stations** list.

- No favorites yet? Press Alt+S for the Station menu, then **Browse Stations...** to search thousands of stations by name, genre, country, or language, listen before you commit, and add the keepers to your favorites. The **ACB Media** submenu is also right there -- the whole ACB stream directory, playable without any setup.
- With favorites: arrow to a station and press **Enter**. That is the whole loop.
- Want the radio on the moment the app opens? Check **Station > Resume Last Station on Launch** once, and Quill Radio becomes an appliance: launch it, and your station is already playing.

Everything Quill Radio announces goes through the same announcement engine QUILL uses, so it speaks through your screen reader (JAWS, NVDA, Narrator) without stealing focus.

## The main window

Tab order: the now-playing line, the favorites list, then three buttons.

- **Now playing** (read-only text): what is on right now; also mirrored in the status bar and the Playback menu.
- **Favorite stations** (list): Enter or double-click plays the selected station. Stations you have filed into folders speak their folder inline; your own custom names are used everywhere.
- Buttons: **Play** (it becomes **Stop** while connecting or playing -- one transport control, never a dead button), **Record**, **Browse Stations...**

## Menus

### Station (Alt+S)

- **Browse Stations...** -- the full station browser: search RadioBrowser's live directory, filter by tag or country, test-play, favorite.
- **Add Custom Station...** -- paste any stream URL and name it yourself.
- **Find Streams from a Website...** -- give it a website address; it scans that one page for stream links, with a Test button that toggles to Stop Test while a candidate plays.
- **Manage Favorites...** -- the favorites, made organizable. See "The Favorites Manager" below.
- **Play Last Station** (Ctrl+L) -- resume whatever you last had on, one keystroke, no navigation.
- **Recently Played** (submenu) -- your last fifteen stations, newest first, playable inline.
- **Favorite Stations** (submenu) -- every favorite, nested by your folders, playable inline.
- **ACB Media** (submenu) -- ACB's whole stream directory, playable inline.
- **Resume Last Station on Launch** (check item) -- the appliance switch.
- **Send to Tray** (Ctrl+W) -- hide the window; playback continues from the notification area.
- **Exit** -- quit Quill Radio.

### Playback (Alt+P)

- A live (disabled) now-playing line at the top, so the menu itself tells you what is on.
- **Play / Stop** (Ctrl+P) -- one transport item that reads Play when idle and Stop while connecting or playing, exactly like the panel button.
- **Mute/Unmute** (Ctrl+M), **Volume Up** (Ctrl+Up), **Volume Down** (Ctrl+Down). Each favorite remembers the volume you set while it plays and gets it back the next time it starts -- stations are mastered wildly differently, and you should only have to fix that once per station.
- **What's Playing?** (Ctrl+T) -- speaks the current track or show title straight from the stream's own metadata.
- **Announce Track Titles** (check item) -- when on, title changes are announced as they happen. Off by default.
- **Sleep Timer...** -- fade out and stop after a set time, restoring your volume.
- **Wake-Up Timer...** -- the sleep timer's twin: pick a favorite, a time, once or every day, and the station starts playing by itself. Quill Radio must be running (the tray counts).

### Record (Alt+R)

- **Record Now / Stop Recording** -- capture the station you are listening to.
- **Record Station...** -- record a *different* station for a set number of minutes while you listen to something else (or to nothing). The recorder is its own process; it never needed the player.
- **Schedule Recording...** -- record a show later, once, daily, or weekly, even from the tray.
- **Recordings...** -- everything you have recorded, live. See "The Recordings list" below.
- **Recording Settings...** -- format (MP3, OGG, FLAC, WAV), bitrate, destination folder, filename pattern, a maximum-length safety cap, and the **If the connection drops** section: reconnect on/off, how many attempts, and how many seconds between them.

### Help (Alt+H)

- **Command Palette...** (Ctrl+Shift+P) -- every Quill Radio command in one searchable list.
- **Redeem Unlock Code...** -- enter a signed code for a pre-release capability. Verified entirely on your machine; nothing is transmitted; one code counts for QUILL, Quill Radio, and QUILL Cast together.
- **Check for Updates...** -- compares your version with the newest release, downloads the installer in-app with spoken progress, then offers Install now or Open folder.
- **About Quill Radio** -- version, sync statement, project address.

## The Favorites Manager

Station > Manage Favorites... is a full organizer, keyboard-first:

- **Search favorites** filters live across names (including your custom names), countries, languages, tags, and folder names; results flatten into one arrow-key list with each station's folder spoken in its label.
- **Folders of any depth.** File a station under "News/Morning" and the folders exist; folders live as long as they hold stations. Rename a folder (F2) and its subfolders come along; delete one and its stations simply step out to the top level -- nothing is ever deleted with a folder.
- **Reordering.** Move Up / Move Down within a folder; for long hops, **Mark for Move**, select the destination, then **Move Above** or **Move Below** -- the moved station joins the destination's folder.
- **Rename** (F2 on a station) gives it your own display name everywhere; blank restores the directory's name.
- Enter plays, Delete removes (with confirmation), Shift+F10 opens every action on the selected item.

## The Recordings list

Record > Recordings... shows the whole recording life cycle in one place, refreshing live:

- The recording being written right now -- status **Recording**, its size growing as you watch.
- Every finished file, newest first -- status **Recorded**, with size and date.
- Upcoming scheduled recordings -- status **Scheduled**, with their times.

Actions: **Play** (through the app's own player), **Stop Recording**, **Open in Folder**, **Remove** (Delete key, with confirmation), **Refresh**. If the internet hiccups during a recording, ffmpeg first rides it out; if the connection truly dies, Quill Radio waits and resumes into a numbered part file, announcing each attempt -- tune or disable this in Recording Settings.

## Hardware media keys

If your keyboard has media keys, Play/Pause and Stop control Quill Radio system-wide while it runs -- even from the tray. Keys another app already owns are left alone.

## The system tray

Closing the window keeps Quill Radio available in the notification area with its own icon. Right-click (or Shift+F10 on) the tray icon for Show, the full radio controls including favorites and recently played, and Exit. Double-click brings the window back.

## Sharing data with QUILL

Quill Radio reads and writes the same data store as QUILL and QUILL Cast (`%APPDATA%\Quill`): favorites (folders, custom names, and per-station volumes included), history, recordings, schedules, timers, and settings. A station you favorite here is a favorite in QUILL's radio; the wake-up timer you set in QUILL fires here. Uninstalling Quill Radio never deletes that shared data.

## Dependencies, honestly stated

- **Playback** uses the Windows Media Player engine built into Windows -- nothing to install.
- **Recording** (and the auto-trim/normalize passes) use **ffmpeg**, which the installer bundles at `tools\ffmpeg` inside the install folder. Nothing downloads at runtime.
- **Station search** talks to the community **RadioBrowser** directory; **Find Streams** fetches only the one page you type; **What's Playing** reads metadata from the stream you are already playing. No other network calls exist, and every one of them is inventoried in QUILL's network-egress audit.
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
