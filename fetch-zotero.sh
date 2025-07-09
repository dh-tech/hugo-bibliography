#!/bin/sh

BIB_FILE="data/bibliography.json"
COLLECTION_FILE="data/collections.json"

GROUP_ID="5010351"

mkdir -p data

curl -s "https://api.zotero.org/groups/$GROUP_ID/items?limit=50?format=json" \
  | jq '[.[] | .data]' > "$BIB_FILE"

curl -s "https://api.zotero.org/groups/$GROUP_ID/collections?format=json" \
  | jq '[.[] | .data]' > "$COLLECTION_FILE"