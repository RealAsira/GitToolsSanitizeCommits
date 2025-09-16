#!/bin/bash

# WARNING: DESTRUCTIVE HISTORY REWRITES; USE ON TEST REPOS FIRST

# Path to projects folder (all sub-dirs being git repos which are to be sanitized)
PROJECTS_ROOT="/c/Users/username/Projects"

# Loop through all subdirectories
for repo in "$PROJECTS_ROOT"/*; do
    if [ -d "$repo/.git" ]; then
        echo ""
        echo "Processing repository: $repo"
        echo ""
        cd "$repo" || continue

# Rewrite all commits
git filter-repo --force --commit-callback '
commit.author_name = b"New Name"
commit.author_email = b"new.email@example.com"
commit.committer_name = b"New Name"
commit.committer_email = b"new.email@example.com"
'

        echo ""
        echo "Done rewriting history for $repo ... result:"
        git log --format="%an <%ae>" | sort -u
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
