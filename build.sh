#!/usr/bin/env bash

set -e
GITHUB_VERSION=$(cat github_version.txt)

echo "1"
wget https://github.com/restic/restic/releases/download/v$GITHUB_VERSION/restic-$GITHUB_VERSION.tar.gz
echo "2"
tar -xzf restic-$GITHUB_VERSION.tar.gz
echo "3"
mv restic-$GITHUB_VERSION restic
echo "4"
cd restic
echo "5"
make all
echo "6"
mkdir output
echo "7"
mv restic output/restic-$GITHUB_VERSION
echo "8"
ls -la output
echo "9"
