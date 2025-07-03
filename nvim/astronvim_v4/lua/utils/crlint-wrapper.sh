#!/bin/bash
# Wrapper to capture both stdout and stderr from crlint
cd "$1" 2>/dev/null || cd "$(dirname "$1")" 2>/dev/null || true
crlint . 2>&1
