#!/usr/bin/env bash
#INFRASTRUCTURE
for path in ~/Documents/napa/infrastructure/*; do
    [ -d "${path}" ] || continue # if not a directory, skip
    dirname="$(basename "${path}")"
    cd $path
    git pull
done

#TRIDENT
for path in ~/Documents/napa/trident/*; do
    [ -d "${path}" ] || continue # if not a directory, skip
    dirname="$(basename "${path}")"
    cd $path
    git pull
done

