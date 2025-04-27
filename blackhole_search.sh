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

# Global variables
SEARCH_QUERY=$1
SEARCH_URL="$BLACKHOLE_SEARCH_URL$SEARCH_QUERY"

DATE=$(date +%Y-%m-%d)
OBSIDIAN_NOTE_NAME="Black Hole Search - $SEARCH_QUERY - $DATE"

FORBIDDEN_FILENAME_CHARACTERS=":/\\"
SANITIZED_OBSIDIAN_NOTE_NAME=$(echo "$OBSIDIAN_NOTE_NAME" | sed "s/[$FORBIDDEN_FILENAME_CHARACTERS]//g")
FILE_PATH="$OBSIDIAN_NOTE_PATH/$SANITIZED_OBSIDIAN_NOTE_NAME.md"
FILE_PATH_EXPANDED=$(eval echo "$FILE_PATH")

# Function to validate required applications and parameters
validate_requirements() {
    # Check if search query is provided
    if [ -z "$SEARCH_QUERY" ]; then
        echo "SEARCH_QUERY is not set. Please set it first."
        exit 1
    fi

    # Check if obsidian is installed on macos
    if [ ! -d "/Applications/Obsidian.app" ]; then
        echo "Obsidian is not installed. Please install it first."
        exit 1
    fi

    if [ -z "$OBSIDIAN_VAULT_NAME" ]; then
        echo "OBSIDIAN_VAULT_NAME is not set. Please set it first."
        exit 1
    fi

    if [ -z "$OBSIDIAN_NOTE_NAME" ]; then
        echo "OBSIDIAN_NOTE_NAME is not set. Please set it first."
        exit 1
    fi
}

# Function to create note template content
create_note_template() {
    cat << EOF
**Objective**: 
**Stop Searching When**: 
**Time Limit**: 10 minutes
**Next Steps**: 
  1. 
  2. 
  3. 

**Ready to Search**: 
EOF
}

create_obsidian_note() {
    local note_content=$(create_note_template)
    local uri="obsidian://new?vault=$OBSIDIAN_VAULT_NAME&name=$SANITIZED_OBSIDIAN_NOTE_NAME&content=$note_content"
    
    echo "Creating new Obsidian note: $SANITIZED_OBSIDIAN_NOTE_NAME"
    open "$uri"
}

wait_for_ready_signal() {
    echo "Waiting for '**Ready to Search**: y' to appear in the file..."
    echo "File path: $FILE_PATH_EXPANDED"
    
    # Poll the file until the last line contains "**Ready to Search**: y"
    while true; do
        if [ -f "$FILE_PATH_EXPANDED" ]; then
            LAST_LINE=$(tail -n 1 "$FILE_PATH_EXPANDED" | tr -d '\r\n')
            echo "Current last line: $LAST_LINE"
            
            if [ "$LAST_LINE" = "**Ready to Search**: y" ]; then
                echo "Opening search URL..."
                return 0
            fi
        else
            echo "File not found yet, waiting..."
        fi
        sleep 1
    done
}

open_search() {
    echo "Opening search URL: $SEARCH_URL"
    open "$SEARCH_URL"
}

main() {
    validate_requirements
    create_obsidian_note
    wait_for_ready_signal
    open_search
}

main