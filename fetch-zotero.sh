#!/bin/sh

set -eu

thescript="${0%.sh}"
echo "DEPRECATED: .sh script is deprecated, just call '$thescript' directly"
"$thescript" "$@"
