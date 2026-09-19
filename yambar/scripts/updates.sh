#!/bin/sh
printf 'output|string|%s\n\n' "$(cat /etc/apk/updatecount 2>/dev/null || echo 0)"
