#!/bin/sh

BIB_FILE="data/bibliography.json"
COLLECTION_FILE="data/collections.json"
GROUP_ID="5945151"
LIMIT=100
START_INDEX=0

mkdir -p data

echo "[]" > "$BIB_FILE"

TOTAL_RESULTS=$(curl -s -I "https://api.zotero.org/groups/$GROUP_ID/items?limit=1" \
  | grep -i "Total-Results:" | awk '{print $2}' | tr -d '\r')

while [ "$START_INDEX" -lt "$TOTAL_RESULTS" ]; do

  curl -s "https://api.zotero.org/groups/$GROUP_ID/items?start="$START_INDEX"?limit=100?format=json" \
  | jq '[.[] | .data]' > "tmp_items.json"

  jq -s '.[0] + .[1]' "$BIB_FILE" tmp_items.json > tmp_merged.json
  mv tmp_merged.json "$BIB_FILE"

  START_INDEX=$((START_INDEX + LIMIT))
done

rm -f tmp_items.json

START_INDEX=0
TOTAL_RESULTS=$(curl -s -I "https://api.zotero.org/groups/$GROUP_ID/collections?limit=1" \
  | grep -i "Total-Results:" | awk '{print $2}' | tr -d '\r')

while [ "$START_INDEX" -lt "$TOTAL_RESULTS" ]; do

  curl -s "https://api.zotero.org/groups/$GROUP_ID/collections?start="$START_INDEX"?limit=100?format=json" \
  | jq '[.[] | .data]' > "tmp_collections.json"

  jq -s '.[0] + .[1]' "$COLLECTION_FILE" tmp_collections.json > tmp_merged.json
  mv tmp_merged.json "$COLLECTION_FILE"
  
  START_INDEX=$((START_INDEX + LIMIT))
done

rm -f tmp_collections.json