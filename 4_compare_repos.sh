#!/bin/bash

# Path to projects folder (all sub-dirs being git repos which were sanitized)
PROJECTS_ROOT="/c/Users/username/Projects"
# Path to your backup folder (original to compare sanitized version to)
PROJECTS_ROOT_BACKUP="/c/Users/username/ProjectsBackup"


for repo in "$PROJECTS_ROOT"/*; do
    repo_name=$(basename "$repo")
    backup_repo=$PROJECTS_ROOT_BACKUP"/$repo_name"
    
    if [ -d "$repo/.git" ] && [ -d "$backup_repo/.git" ]; then
        echo "Comparing $repo_name with backup..."
        diff -r "$repo" "$backup_repo"
        # or for a shorter summary:
        # diff -qr "$repo" "$backup_repo"
    fi
done
