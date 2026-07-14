"""Quill Radio standalone launcher.

The application itself lives in the ``quill`` package (``quill.apps.radio``)
and runs the exact same feature code QUILL uses -- same station browser,
same favorites, same recorder. This package is only the product wrapper:
it anchors QUILL_APP_ROOT for the frozen build (so the bundled ffmpeg in
``tools\\ffmpeg`` next to the exe is found) and hands off to the app.
"""

import os
import sys
from pathlib import Path


def _export_app_root() -> None:
    """Point QUILL_APP_ROOT at the install directory of the frozen build.

    ``quill.core.speech.ffmpeg.ffmpeg_search_dirs`` checks
    ``{QUILL_APP_ROOT}/tools/ffmpeg`` first, which is exactly where the
    installer places the bundled ffmpeg/ffprobe. Never overrides an
    explicitly set environment.
    """
    if os.environ.get("QUILL_APP_ROOT"):
        return
    if not getattr(sys, "frozen", False):
        return
    anchor = Path(sys.executable).resolve().parent
    if (anchor / "tools" / "ffmpeg").is_dir():
        os.environ["QUILL_APP_ROOT"] = str(anchor)


def main() -> int:
    _export_app_root()
    from quill.apps.radio import main as run

    return run()


__all__ = ["main"]
