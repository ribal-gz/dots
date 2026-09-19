#!/bin/sh

output="$1"

format() {
    jq -r '
        .tags[] |
        "show\(.index)|bool|\(
            if .client_count > 0 or .is_active or .is_urgent
            then "true"
            else "false"
            end
        )",
        "active\(.index)|bool|\(.is_active)",
        "urgent\(.index)|bool|\(.is_urgent)"
    '

    printf '\n'
}

mmsg watch tags "$output" 2>/dev/null |
    while IFS= read -r line; do
        printf '%s\n' "$line" | format
    done
