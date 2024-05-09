#!/usr/bin/env bash
set -euo pipefail
set -x

desc=$(git describe --tags)
last_version=${desc%%-*}

get_next_version() {
  sed -e "/^# ${last_version}/q" <CHANGELOG.md \
    | head -n-1 | grep -om1 '# v..*' | grep -o 'v.*'
}

regen_changelog() {
  while read -r line; do
    if [[ $line =~ ^##*\ \ #v ]]; then
      echo "# ${next_version:-vNEXT}"
      echo
      echo '```git log --pretty=oneline'
      git log "$last_version".. --pretty=oneline
      echo '```'
      echo
    fi
    echo "$line"
  done <CHANGELOG.md
}

edit_changelog() {
  regen_changelog >newch
  mv newch CHANGELOG.md
  $EDITOR CHANGELOG.md
  next_version=$(get_next_version)
  if ! git diff --quiet CHANGELOG.md; then
    git add CHANGELOG.md
    git commit -m "Update changelog for $next_version"
  fi
}

prep_next_version() {
  [ -n "$next_version" ]
  git tag -f "$next_version"
  make -j2 regen
  git tag -f "$next_version"
}

edit_changelog
prep_next_version

# TODO cut release by tag promotion
# git tag -a -f "$next_version" $next_version
