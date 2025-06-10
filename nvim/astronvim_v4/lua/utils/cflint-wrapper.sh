#!/bin/bash
# Wrapper to capture both stdout and stderr from cflint
cd "$1" 2>/dev/null || cd "$(dirname "$1")" 2>/dev/null || true
cflint . 2>&1