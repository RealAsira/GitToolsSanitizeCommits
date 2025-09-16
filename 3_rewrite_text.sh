#!/bin/bash

# WARNING: DESTRUCTIVE HISTORY REWRITES; USE ON TEST REPOS FIRST

# Path to projects folder (all sub-dirs being git repos which are to be sanitized)
PROJECTS_ROOT="/c/Users/username/Projects"
# Path to file that contains find and replace values
REPLACE_TEXT="/c/Users/username/Desktop/rewrite_text.txt"
# e.g. each line is an entry (no spaces)
# oldText==>newText

# Loop through all subdirectories and replace text throughout the entire repo+history
for repo in "$PROJECTS_ROOT"/*; do
    if [ -d "$repo/.git" ]; then
        echo ""
        echo "Replacing text in repo: $repo"
        echo ""
        cd "$repo" || continue

        # Rewrite text
        git filter-repo --force --replace-text $REPLACE_TEXT
        git reset --hard HEAD

        echo ""
        echo "Done rewriting confidential information for $repo ... result:"
        git grep -i "keywords\|to\|check\|if\|have\|been\|removed\|separated\|by\|escaped\|pipe\|chars" $(git rev-list --all)
        echo ""
        echo ""
    else
        echo ""
        echo "$repo is not a git repository, skipping..."
    fi
done

echo ""
echo "ALL REPOS PROCESSED."
echo ""
