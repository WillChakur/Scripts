#!/bin/bash
# Stop script if any step fails
set -eo pipefail

repo="$1"
file="$2"

if [ -z "$repo" ] || [ -z "$file" ]; then
    echo "ERROR: Please include repo name followed by filename or * (glob) for the entire directory."
    exit 1
fi

git status

read -p "Would you like to push changes? (y/n): " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$file" != "*" ]; then
        git add "$file"
    else
        git add .
    fi
    echo
elif [[ $REPLY =~ ^[Nn]$ ]]; then
    echo
    echo "No changes pushed."
    sleep 2
    exit
fi

echo "Please enter a commit message:"
read -r message

git commit -m "$message"
git push git@github.com:WillChakur/"$repo".git

echo "HAVE A NICE DAY!!"
sleep 2