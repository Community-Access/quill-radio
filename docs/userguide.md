# Quill Radio User Guide

Version 1.0

Quill Radio is internet radio the way a screen reader user would design it: a small window whose favorites list has focus the instant it opens, a menu bar that says everything it does, spoken feedback for every action, and a tray icon so the music keeps playing while you work.

## Getting started

Launch Quill Radio from the Start Menu (or `quill-radio` from a terminal if you installed from source). The window opens with keyboard focus on your **Favorite stations** list.

- No favorites yet? Press Alt+S for the Station menu, then choose **Browse Stations...** to open the station browser, search by name, genre, country, or language, and add stations to your favorites.
- With favorites: arrow to a station and press **Enter** to play it. That is the whole loop.

Everything Quill Radio announces goes through the same announcement engine QUILL uses, so it speaks through your screen reader (JAWS, NVDA, Narrator) without stealing focus.

## The main window

Tab order: the now-playing line, the favorites list, then four buttons.

- **Now playing** (read-only text): what is playing right now; also mirrored in the status bar and the Playback menu.
- **Favorite stations** (list): Enter or double-click plays the selected station.
- Buttons: **Play** (becomes **Stop** while playing), **Record**, **Browse Stations...**

## Menus

### Station (Alt+S)

- **Browse Stations...** -- the full station browser: search, filter, listen, favorite.
- **Add Custom Station...** -- paste any stream URL and name it yourself.
- **Find Streams from a Website...** -- give it a website address; it finds the audio streams on that page.
- **Favorites** (submenu) -- your stations inline, playable straight from the menu. Shared with QUILL, so a station favorited there is here too.
- **ACB Media** (submenu) -- ACB's whole stream directory, playable inline, no dialog hunt.
- **Send to Tray** (Ctrl+W) -- hide the window; playback continues from the notification area.
- **Exit** -- quit Quill Radio.

### Playback (Alt+P)

- A live (disabled) now-playing line at the top, so the menu itself tells you what is on.
- **Play** (Ctrl+P) -- one transport item: it reads Play when idle and Stop while connecting or playing, exactly like the panel button.
- **Mute/Unmute** (Ctrl+M), **Volume Up** (Ctrl+Up), **Volume Down** (Ctrl+Down).

### Record (Alt+R)

- **Record Now / Stop Recording** -- capture the current station to a file.
- **Schedule Recording...** -- record a show later, even with the app closed to tray.
- **Recording Settings...** -- where recordings land and how they are named.

### Help (Alt+H)

- **Redeem Unlock Code...** -- enter a signed unlock code for a pre-release capability. Verified entirely on your machine; nothing is transmitted. A code redeemed here is redeemed for QUILL and QUILL Cast too -- all three share one unlock store.
- **Check for Updates...** -- compares your version with the newest release of Quill Radio, downloads the installer in-app with spoken progress, then offers Install now (closes the app and runs the installer) or Open folder.
- **About Quill Radio** -- version, sync statement, and the project address.

## The system tray

Closing the window keeps Quill Radio available in the notification area. Right-click (or Shift+F10 on) the tray icon for Show, the radio controls, and Exit. Double-click to bring the window back.

## Recordings

Record Now writes the current stream to disk from the moment you press it; press again to stop. Scheduled recordings run at the time you set. Find both under the folder configured in **Record > Recording Settings...**

## Sharing data with QUILL

Quill Radio reads and writes the same data store as QUILL and QUILL Cast (`%APPDATA%\Quill`). A station you favorite here is a favorite in QUILL's Radio; settings changed there apply here. Uninstalling Quill Radio never deletes that shared data.

## Keyboard reference

| Action | Key |
| --- | --- |
| Play / Stop | Ctrl+P |
| Mute / Unmute | Ctrl+M |
| Volume up / down | Ctrl+Up / Ctrl+Down |
| Send to tray | Ctrl+W |
| Play selected favorite | Enter (in the list) |
| Station menu | Alt+S |
| Playback menu | Alt+P |
| Record menu | Alt+R |
| Help menu | Alt+H |

These keys belong to Quill Radio's own menus and are kept separate from QUILL's keymap, so nothing here collides with editor shortcuts.

## Troubleshooting

- **A station will not play.** Streams move and die; try the same station from Browse Stations again (the directory entry may have a fresh URL), or re-add it as a custom station.
- **No sound but the app says playing.** Check Mute/Unmute in the Playback menu and your Windows volume mixer entry for Quill Radio.
- **The tray icon is gone.** Some Windows setups hide new tray icons; check the taskbar overflow area, or set Quill Radio to "always show" in Windows taskbar settings.
