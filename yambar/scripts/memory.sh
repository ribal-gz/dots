#!/bin/sh
printf 'output|string|%s\n\n' "$(free -h | awk '/^Mem/ { print $3"/"$2 }' | sed s/i//g)"
