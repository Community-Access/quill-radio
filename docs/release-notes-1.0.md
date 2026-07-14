# Quill Radio 1.0 -- Release Notes

The radio, on its own. Quill Radio takes the internet radio QUILL users already know and gives it a window, a menu bar, and a tray icon of its own -- for the days you want the music without the manuscript.

## Highlights

- **Favorites first.** The app opens with your favorite stations focused; Enter plays. No ribbon, no dashboard, no hunting.
- **The full station browser.** Search by name, genre, country, or language across the same live directory QUILL uses; add custom stream URLs; point the stream finder at a website and let it dig the audio out.
- **Recording, live and scheduled.** Record what is playing right now, or schedule a show for later -- the same recorder and scheduler QUILL ships.
- **A tray citizen.** Close to the notification area and keep listening; play, pause, and switch stations from the tray menu.
- **Spoken feedback everywhere.** Every action announces its outcome through your screen reader -- JAWS, NVDA, or Narrator -- without stealing focus.
- **One data store.** Favorites, settings, and recordings are shared with QUILL and QUILL Cast. Favorite a station here, see it there.
- **Check for Updates, built in.** Signed unlock codes are verified entirely offline and count for all three apps; the update check compares your version against this repository's releases and offers the download page.
- **Open in Quill.** The full editor is one menu item away when you need it.

## What Quill Radio deliberately is not

It is not QUILL minus some menus -- it is the radio, period. The editor, AI, transcription, braille, and speech-synthesis stacks are not installed at all, which keeps the install small and the app simple. When you want them, Help > Open in Quill.

## Not a fork -- a guarantee

Quill Radio runs the exact same radio feature code as QUILL, from the same upstream package. Fixes and features land upstream once and reach QUILL, Quill Radio, and QUILL Cast together. This repository only carries the wrapper, the installer, and these docs.

## Requirements

Windows 10 or 11, x64 (or ARM64 under emulation). No Python installation required.

## Known limitations

- Check for Updates opens the release page rather than updating in place.
- Global hotkeys for transport are configured from full QUILL (Tools > Global Hotkeys...), not from this app, in 1.0.
