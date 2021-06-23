#!/bin/bash

set -e

# check for existing cache cache
cached=$(deno info a.ts | grep emit: | cut -d' ' -f2- )
if [ $cached ] ; then
  echo "Cached files found. Do 'rm -r ${cached%/*}' first"
  exit 1
else
  echo "Cache is clean. Proceeding..."
fi

set -v
# Run a.ts
deno run --unstable a.ts
deno run --unstable a.ts # good, cache hit

# Run b.ts
deno run b.ts

echo 'Cache is now "broken", so the following lines will print "Checking a.ts" every time'

# Run a.ts
deno run --unstable a.ts # bad, no cache hit :(
deno run --unstable a.ts # bad, no cache hit :(
deno run --unstable a.ts # bad, no cache hit :(
deno run --unstable a.ts # bad, no cache hit :(
