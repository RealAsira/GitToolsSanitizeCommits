# Git Commit and History Sanitizer

As you can imagine, once you read further into what this tool does, I recently attended a security conference and am increasingly paranoid about my privacy and security. As such, I've chosen to take extensive measures to ensure a certain level of anonymity on the internet.

This repository is one such step. Introducing the **Git Commit and History Sanitizer** by Asira. These files, when run, replace all commit authors and email addresses in git repositories. Further, an optional step can be taken to overwrite old commit histories to expunge information that never should have been in the history or files.

## DISCLAIMER

WARNING: This sanitization process is highly destructive. All history and authors are aggressively overwritten and entirely non-recoverable. Use at your own risk.

WARNING: Once the local, sanitized versions are pushed to the remote, any forks or clones will need to be rebased or re-cloned. Using this tool for any public or shared repositories is NOT recommended.

NOTE: This does not purge any binary files. This tool only works on UTF-8 TEXT files (e.g. even .sql files may not work, especially if they were exported from a database or database tool like SSMS).

### Dependencies

- Git
- [git-filter-repo](https://github.com/newren/git-filter-repo)

### Quick Start

TLDR:

0 - Backups.
(Optional)
1 - Modify and run 1_rewrite_authors.sh
2 - Modify and run 2_validate_authors.sh
(Optional)
3 - Modify and run 3_rewrite_text.sh
4 - Modify and run 4_compare_repos.sh. Validate code still works.
5 - Modify and run 5_origin_reinstate.sh
6 - Modify remote perms to allow overwrite+forcepush without restriction.
7 - Modify and run 6_forcepush_all.sh
8 - Reinstate remote protections.

### How to Use

0 - CREATE A BACKUP OR TWO. Seriously ... if you skipped the disclaimer, go read it again.

1 - Determine which repo(s) are to be sanitized. Put each repo into a folder (e.g. /c/User/username/SanitizeProjects).

2 - If commit authors don't need to be modified, skip to step 7. Otherwise, continue to step 6.

3 - Modify 1_rewrite_authors.sh by updating the `New Name` and `new.email@example.com` text. These are the new name and email address that will replace the old commit authors and committers. Further modify 1_rewrite_authors.sh by updating `$PROJECTS_ROOT` to the appropriate target directory.

WARNING: 1_rewrite_authors.sh does NOT filter commit authors. EVERY author name and email will be overwritten. If you need to preserve names or emails for other authors, you'll need to modify the script to include a filter.

4 - Run 1_rewrite_authors.sh in BASH (e.g GitBash). The script will hit EVERY repository under `$PROJECTS_ROOT`.

5 - Run 2_validate_authors.sh in BASH (e.g GitBash). This script returns each unique author/committer for each repo.

6 - If commit text doesn't need to be modified, skip to step 11. Otherwise, continue to step 6.

7 - Modify rewrite_text.txt. The left side of `==>` is the string literal to be replaced. The right side is the string literal that replaces the left side. Ensure LF is used instead of CLRF for line breaks (required).

8 - Modify 3_rewrite_text.sh by updating `$PROJECTS_ROOT` and `$REPLACE_TEXT` (the former is the sanitization directory, the latter is the rewrite_text.file). Additionally, it is recommended to modify the `git grep -i` command to include keywords that are being filtered. It will return any matches that were missed during the replacement process.

9 - Run 3_rewrite_text.sh in BASH (e.g GitBash). The script will hit EVERY repository under `$PROJECTS_ROOT`.

10 - Run 4_compare_repos.sh in BASH (e.g GitBash) after modifying `$PROJECTS_ROOT` and `$PROJECTS_ROOT_BACKUP` (in-depth scan of historical files to see diffs between original and sanitized); It is also highly recommended to thoroughly test the sanitized repo(s) still function properly. Unit testing and use-case scenario testing should be performed.

11 - During both the author rewrite and text rewrite stages, remote (origin) references are stripped from the repos. This is to protect the remote from accidental changes. 5_origin_reinstate.sh adds remotes back in for each repo. Start by updating `$PROJECTS_ROOT`. Next, ensure the folder containing each repo is named identically to the remote name. For example, if the remote is `https://github.com/realasira/GitToolsSanitizeCommits` then the local repository's containing folder should be named `GitToolsSanitizeCommits`.

WARNING: It is recommended to temporarily disable any kind of automatic remote pulls/fast-forwards that occur when using tools such as GitKraken. These tools will overwrite the sanitized local repositories if a pull happens.

12 - Run 5_origin_reinstate.sh in BASH (e.g. GitBash) OR manually add remotes.

13 - Modify 6_forcepush_all.sh by updating `$PROJECTS_ROOT`. On the remote repository(ies), disable force push and overwrite protections (ONLY once you are certain the sanitized version(s) are ready to overwrite the originals).

14 - THIS IS THE POINT OF NO RETURN. Run 6_forcepush_all.sh in BASH (e.g. GitBash). The local, sanitized repos are forcefully pushed onto the origin(s), overwriting them entirely.

15 - Validate the remote matches the local sanitized version. Reinstate rulesets and protections.

16 - Congratulations, you've bent git history to your will. May Linus nor your colleagues ever find out.
