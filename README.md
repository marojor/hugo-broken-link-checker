# Hugo Broken Link Action

This action takes a github repo, builds a Hugo site and crawl it looking for broken links.

It's inspired in https://github.com/marccampbell/hugo-linkcheck-action but a tad more up-to-date and using https://github.com/filiph/linkcheck instead of https://github.com/stevenvachon/broken-link-checker.

## Quick Start

Add the following workflow to your repo:

```
name: Hugo broken link check

on:
  pull_request:
    branches:
      - main

jobs:
  broken-link-check:
    runs-on: ubuntu-latest
    name: Check for broken links
    steps:
    - name: Checkout code
      uses: actions/checkout@v2
      with:
        fetch-depth: 1
    - name: Check for broken Links
      uses: marojor/hugo-broken-link-checker@v1.0.5
      with:
        skip-file: 'skip-rules-for-broken-links-check.txt'
```
