#!/bin/bash

# WARNING: DESTRUCTIVE HISTORY REWRITES; USE ON TEST REPOS FIRST

# Path to projects folder (all sub-dirs being git repos which are to be force pushed)
PROJECTS_ROOT="/c/Users/username/Projects"

# Loop through all subdirectories
for repo in "$PROJECTS_ROOT"/*; do
    if [ -d "$repo/.git" ]; then
        repo_name=$(basename "$repo")

        echo ""
        echo "$repo_name force push:"
        echo "https://github.com/userhandle/$repo_name.git"
        echo ""
        
        cd "$repo" || continue
        git push origin --all --force
        git push origin --tags --force
    else
        echo ""
        echo "$repo is not a git repository, skipping..."
    fi
done
