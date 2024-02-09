#!/bin/bash
# From https://praneethreddybilakanti.medium.com/how-to-delete-old-remote-git-branches-via-bash-script-712fab26a536

# Run this script inside a git repository, to delete old remote git branches

MAX_DAYS=120
# Function to log messages using the logger command
# Define colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

log() {
    local level=$1
    local message=$2

    case $level in
        "info")
            echo -e "${GREEN}${message}${NC}"
            ;;
        "warn")
            echo -e "${YELLOW}${message}${NC}"
            ;;
        *)
            echo "$message"
            ;;
    esac
}

branches=$(git branch -r | sed 's/origin\///')
# echo "$branches"
# Initialize counter
counter=0
for branch in $branches; do
    last_commit_date=$(git show --no-patch --format=%ci "origin/$branch" | head -n 1)
    branch_age=$((($(date +%s) - $(date -d "$last_commit_date" +%s)) / (60 * 60 * 24)))
    # echo "$last_commit_date -> $branch_age"
    if [[ $branch_age -gt $MAX_DAYS ]]; then
        log "info" "${GREEN}Deleted branch $branch in repository ${NC}"

        # git push origin --delete "$branch"
        ((counter++))
    else
        log "info" "${YELLOW}Skipping branch $branch (age: $branch_age days)${NC}"
    fi

done

echo "Total branches deleted: $counter"