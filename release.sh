#!/usr/bin/env bash
set -euo pipefail
set -x

desc=$(git describe --tags)
last_version=${desc%%-*}

if ! next_version=$(sed -e "/^# ${last_version}/q" <CHANGELOG.md | head -n-1 | grep -om1 '# v..*' | grep -o 'v.*'); then

  while read -r line; do
    if [[ $line =~ "$last_version" ]]; then
      echo "# vNEXT"
      echo
      echo '```git log --pretty=oneline'
      git log "$last_version".. --pretty=oneline
      echo '```'
      echo
    fi
    echo "$line"
  done <CHANGELOG.md >newch
  mv newch CHANGELOG.md
  $EDITOR CHANGELOG.md

  next_version=$(sed -e "/^# ${last_version}/q" <CHANGELOG.md | head -n-1 | grep -om1 '# v..*' | grep -o 'v.*')
  git add CHANGELOG.md
  git cim "Update changelog for $next_version"

fi

git tag "$next_version"

rm -f pchepa.scad && git checkout -f pchepa.scad

make -j2 regen

git tag -a -f "$next_version"
