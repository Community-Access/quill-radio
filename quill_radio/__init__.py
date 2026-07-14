"""Quill Radio standalone launcher.

The application itself lives in the ``quill`` package (``quill.apps.radio``)
and runs the exact same feature code QUILL uses -- same station browser,
same favorites, same recorder. This package is only the product wrapper.
"""

from quill.apps.radio import main

__all__ = ["main"]
