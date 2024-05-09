#!/usr/bin/env bash
set -e

case "$1" in

  smudge)
    desc=$(git describe --always --all --abbrev)
    desc=${desc#*/}
    sed -r \
      -e 's/".*";( *\/\/ *\$gitvar\$describe\$)/"'"$desc"'";\1/'
    ;;

  clean)
    sed -r -e 's/".*";( *\/\/ *\$gitvar\$(.+)\$)/"";\1/'
    ;;

  *)
    cat
    ;;
esac
