#!/bin/bash

# WARNING: DESTRUCTIVE HISTORY REWRITES; USE ON TEST REPOS FIRST

# Path to projects folder (all sub-dirs being git repos which need origin batch-assigned)
PROJECTS_ROOT="/c/Users/username/Projects"

# Loop through all subdirectories and applies subdir folder name as the remote origin name
for repo in "$PROJECTS_ROOT"/*; do
    if [ -d "$repo/.git" ]; then
        repo_name=$(basename "$repo")

        echo ""
        echo "$repo_name add origin:"
        echo "https://github.com/userhandle/$repo_name.git"
        echo ""
        
        cd "$repo" || continue
        git remote remove origin 2>/dev/null
        git remote add origin "https://github.com/userhandle/$repo_name.git"
        git remote -v
    else
        echo ""
        echo "$repo is not a git repository, skipping..."
    fi
done
