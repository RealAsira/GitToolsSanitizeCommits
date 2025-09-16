#!/bin/bash

# Path to projects folder (all sub-dirs being git repos which are to be validated)
PROJECTS_ROOT="/c/Users/username/Projects"

# Loop through all subdirectories ... validates the name and email for each commit
for repo in "$PROJECTS_ROOT"/*; do
    if [ -d "$repo/.git" ]; then
        echo ""
        echo "Repo $repo Validation Check:"
        echo ""
        cd "$repo" || continue
        git log --format="%an <%ae>" | sort -u
    else
        echo ""
        echo "$repo is not a git repository, skipping..."
    fi
done
