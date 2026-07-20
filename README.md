# Quill Radio

Quill Radio's source code, build tooling, and documentation now live in the
**QUILL monorepo**: [`Community-Access/quill`](https://github.com/Community-Access/quill)
— the app itself is `quill.apps.radio`, and its standalone packaging (launcher,
PyInstaller spec, installer, build script, docs) is under
[`standalone/radio/`](https://github.com/Community-Access/quill/tree/main/standalone/radio).

This repository is retained as the **release host** for Quill Radio. It exists so that:

- **Automatic updates keep working** — the in-app "Check for Updates" reads this
  repo's [Releases](../../releases), and every shipped copy of Quill Radio polls
  it. This repo must not be deleted.
- **Bug reports have a home** — "Report a Bug" files issues here.

It intentionally contains **no source or build tooling** — those moved to the
monorepo so the packaging can never drift from the code it packages. To build or
release Quill Radio, use `standalone/radio/` in `Community-Access/quill`.

Prior contents remain in this repo's git history.
