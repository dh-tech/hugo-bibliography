#!/bin/sh

BIB_FILE="data/bibliography.json"
COLLECTION_FILE="data/collections-flat.json"
GROUP_ID="${ZOTERO_GROUP_ID:-5010351}"
LIMIT=25
START_INDEX=0

mkdir -p data

echo "[]" > "$BIB_FILE"
echo "[]" > "$COLLECTION_FILE"

TOTAL_RESULTS=$(curl -s -I "https://api.zotero.org/groups/$GROUP_ID/items?limit=1" \
  | grep -i "Total-Results:" | awk '{print $2}' | tr -d '\r')

while [ "$START_INDEX" -lt "$TOTAL_RESULTS" ]; do

  curl -s "https://api.zotero.org/groups/$GROUP_ID/items?start="$START_INDEX"?limit=$LIMIT?format=json" \
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

  curl -s "https://api.zotero.org/groups/$GROUP_ID/collections?start="$START_INDEX"?limit=$LIMIT?format=json" \
  | jq '[.[] | .data]' > "tmp_collections.json"

  jq -s '.[0] + .[1]' "$COLLECTION_FILE" tmp_collections.json > tmp_merged.json
  mv tmp_merged.json "$COLLECTION_FILE"
  
  START_INDEX=$((START_INDEX + LIMIT))
done

rm -f tmp_collections.json

python3 <<EOF
import json

with open("data/collections-flat.json") as f:
    collections = json.load(f)

collection_map = {collection["key"]: {**collection, "children": []} for collection in collections}
roots = []

for collection in collections:
    if collection.get("parentCollection"):
        parent = collection_map.get(collection["parentCollection"])
        if parent:
            parent["children"].append(collection_map[collection["key"]])
    else:
        roots.append(collection_map[collection["key"]])

with open("data/collections.json", "w") as f:
    json.dump(roots, f, indent=2)
EOF
