#!/bin/bash

# This script shows how this repository was created.

# First, clone the repository
git clone https://github.com/apache/thrift thrift-php
cd thrift-php

# Fetch all branches
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    git branch --track ${branch##*/} $branch
done

# Remove everything except the lib/php directory
git filter-branch -f --prune-empty --tag-name-filter cat --subdirectory-filter lib/php -- --all

# Add the extra text to indicate that this has been cloned.
cat README.md | sed -e 's/^License$/This repository was cloned from https:\/\/github.com\/apache\/thrift using the script found in create-mirror.sh\n\nLicense/' > README.md.tmp
mv README.md.tmp README.md