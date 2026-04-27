#!/usr/bin/env bash
set -u

dir="$HOME/programs/appimages/gdlauncher"
pattern='GDLauncher__*__linux__x64.AppImage'

show_error() {
    zenity --error \
        --title="GDLauncher" \
        --width=420 \
        --text="$1"
}

latest="$(
    find "$dir" -maxdepth 1 -type f -name "$pattern" -printf '%T@ %p\n' 2>/dev/null \
    | sort -nr \
    | head -n1 \
    | cut -d' ' -f2-
)"

if [ -z "$latest" ]; then
    show_error "No GDLauncher AppImage was found in:

$dir"
    exit 1
fi

if [ ! -x "$latest" ]; then
    if ! chmod +x "$latest" 2>/dev/null; then
        show_error "Could not make this AppImage executable:

$latest"
        exit 1
    fi
fi

"$latest" --no-sandbox
status=$?

if [ "$status" -ne 0 ]; then
    show_error "GDLauncher failed to start.

File:
$latest

Exit code: $status"
    exit "$status"
fi
