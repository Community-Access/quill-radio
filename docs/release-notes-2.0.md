# Quill Radio 2.0 -- Release Notes

Quill Radio 2.0 is about one thing done thoroughly: recordings you can trust. Version 1.1.0 rebuilt the sound -- a new playback engine, every stream format, live rewind, richer Sound Enhancements. 2.0 turns that same care on the recorder, closing a reported round of recording bugs and adding the one piece that was always missing: a recording that survives a restart. If you schedule shows, leave long recordings running unattended, or have ever come back to find a capture cut short or gone entirely, this release is for you.

As always, everything below also lands in QUILL itself. Quill Radio and QUILL share one codebase and one data store, so these fixes arrive in both at once -- nothing here is vendored into the Quill Radio wrapper.

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
