#!/bin/bash

# Custom xdg-open script

# Check if inside VSCode and WSL
if [[ -n "$VSCODE_IPC_HOOK_CLI" && -n "$WSL_DISTRO_NAME" ]]; then
    # We are inside VSCode connected to WSL, use code to open files
    code "$@"
else
    # Fallback to the original xdg-open behavior
    /usr/bin/xdg-open "$@"  # Adjust this path as needed
fi
