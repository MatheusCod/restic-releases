#!/usr/bin/env bash

set -e
github_version=$(cat github_version.txt)

echo "1"
wget https://github.com/restic/restic/releases/download/v$github_version/restic-$github_version.tar.gz
echo "2"
tar -xzf restic-$github_version.tar.gz
echo "3"
mv restic-$github_version restic
echo "4"
cd restic
echo "5"
make all
echo "6"
mkdir output
echo "7"
mv restic output/restic-$github_version
echo "8"
ls -la output
echo "9"
