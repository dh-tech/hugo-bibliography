#!/bin/sh

BIB_FILE="data/bibliography.json"

GROUP_ID="5010351"

mkdir -p data

curl -s "https://api.zotero.org/groups/$GROUP_ID/items?format=json" \
  | jq '[.[] | .data]' > "$BIB_FILE"