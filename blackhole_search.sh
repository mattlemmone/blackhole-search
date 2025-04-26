#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Blackhole Search
# @raycast.mode silent

# Optional parameters:
# @raycast.author Matt Lemmone
# @raycast.description Create a new Obsidian note with a search query, and open the search results in Perplexity after a short delay, allowing you to think before you search.
# @raycast.icon 🔍
# @raycast.argument1 { "type": "text", "placeholder": "Search Query" }
# @raycast.argument2 { "type": "text", "placeholder": "Time Limit (minutes)" }

WAIT_TIME_BEFORE_SEARCHING_SEC=5
SEARCH_QUERY=$1
TIME_LIMIT_MINUTES=$2
SEARCH_URL="https://www.perplexity.ai/search?q=$SEARCH_QUERY"

OBSIDIAN_VAULT="iOS Vault"
DATE=$(date +%Y-%m-%d)
OBSIDIAN_NOTE_NAME="Black Hole Search - $SEARCH_QUERY - $DATE"
OBSIDIAN_NOTE_CONTENT="""
**Objective**: 
**Stop Searching When**: 
**Time Limit**: $TIME_LIMIT_MINUTES minutes
**What I could do instead**: 
  1. 
  2. 
  3. 
"""

# Check if obsidian is installed on macos
if [ ! -d "/Applications/Obsidian.app" ]; then
    echo "Obsidian is not installed. Please install it first."
    exit 1
fi

if [ -z "$OBSIDIAN_VAULT" ]; then
    echo "OBSIDIAN_VAULT is not set. Please set it first."
    exit 1
fi

if [ -z "$OBSIDIAN_NOTE_NAME" ]; then
    echo "OBSIDIAN_NOTE_NAME is not set. Please set it first."
    exit 1
fi

FORBIDDEN_FILENAME_CHARACTERS=":/\\"
SANITIZED_OBSIDIAN_NOTE_NAME=$(echo "$OBSIDIAN_NOTE_NAME" | sed "s/[$FORBIDDEN_FILENAME_CHARACTERS]//g")

URI="obsidian://new?vault=$OBSIDIAN_VAULT&name=$SANITIZED_OBSIDIAN_NOTE_NAME&content=$OBSIDIAN_NOTE_CONTENT"

open "$URI"
sleep "$WAIT_TIME_BEFORE_SEARCHING_SEC"
open "$SEARCH_URL"