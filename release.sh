#!/usr/bin/env bash
set -euo pipefail
set -x

desc=$(git describe --tags)
last_version=${desc%-*-g*}

get_next_version() {
  t=$(git cat-file -t "${last_version}" || echo '')
  if [ "$t" != 'tag' ]; then
    echo "${last_version}"
  else
    sed -e "/^# ${last_version}/q" <CHANGELOG.md \
      | head -n-1 | grep -om1 '# v..*' | grep -o 'v.*'
  fi
}

regen_changelog() {
  {
    while IFS= read -r line; do
      if [[ $line =~ ^##*\ \ *v ]]; then
        echo "# ${next_version:-vNEXT}"
        echo
        echo '```git log --pretty=oneline'
        git log "$last_version".. --pretty=oneline
        echo '```'
        echo
        echo "$line"
        break
      fi
      echo "$line"
    done
    while IFS= read -r line; do
      echo "$line"
    done
  } <CHANGELOG.md
}

get_changes() {
  {
    while IFS= read -r line; do
      if [[ $line =~ ^##*\ \ *$next_version ]]; then
        echo "${next_version}"
        break
      fi
    done
    while IFS= read -r line; do
      if [[ $line =~ ^# ]]; then
        break
      fi
      echo "$line"
    done
  } <CHANGELOG.md
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
  next_version=${1}
  [ -n "$next_version" ]
  t=$(git cat-file -t "${next_version}" || echo '')
  if [ "$t" = 'tag' ]; then
    echo "ERROR: ${next_version} already released" >&1
    exit 1
  fi

  git tag -f "$next_version"
  make -j6 regen
  git tag -f "$next_version"
}

case "$1" in

ed|edit)
  edit_changelog
  ;;

prep|regen)
  if [ $# -lt 2 ]; then
    prep_next_version "$(get_next_version)"
  else
    prep_next_version "$2"
  fi
  ;;

pub|tag)
  next_version=$(get_next_version)
  [ -n "$next_version" ]
  t=$(git cat-file -t "${next_version}" || echo '')
  if [ "$t" = 'tag' ]; then
    echo "ERROR: ${next_version} already released" >&1
    exit 1
  fi
  get_changes | git tag -F - -f "${next_version}" "${next_version}"
  ;;

esac
