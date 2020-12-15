#!/bin/bash
# If you feel the need to criticize this script, please note that it
# is an ad-hoc solution for an ad-hoc problem with little to no
# scalability.

if [ -z "$BASH_VERSION" -a -z "$ZSH_VERSION" ]; then
  echo "Please use a BASH-like shell to run this script."
  exit 1
fi
if [ ! -e .git/ ]; then
  echo "Please run this script inside the root folder of a git project."
  exit 1
fi
if [[ -n "$ZSH_VERSION" ]]; then
  setopt extendedglob
else
  shopt -s extglob
  shopt -s globstar
  if [ $? -ne 0 ]; then
    echo "Plese use a BASH shell with a version >= 4.0"
    echo "BASH_VERSION=$BASH_VERSION"
    exit 1
  fi
fi
  

# The following environment variables modify the script's behavior
readonly YES=yes
readonly NO=no
CSS_COMPILED=${CSS_COMPILED:-'built'}
LESS_IGNORE=${LESS_IGNORE:-'_*.*ss'}
LESS_MATCH=${LESS_MATCH:-'src/**/*.less'}
RUN_GULP=${RUN_GULP:-$YES}
RUN_GULP_STYLES=${RUN_GULP_STYLES:-$YES}
RUN_HINT=${RUN_HINT:-$YES}
RUN_LESS=${RUN_LESS:-$YES}
RUN_LHCI=${RUN_LHCI:-$NO}
RUN_SASS=${RUN_SASS:-$YES}
RUN_STYLELINT=${RUN_STYLELINT:-$YES}
SASS_IGNORE=${SASS_IGNORE:-'_*.*ss'}
SASS_SOURCE=${SASS_SOURCE:-'src/**/*.{sass,scss}'}
STYLELINT_MATCH_PATTERN=${STYLELINT_MATCH_PATTERN:-'src/**/*.{css,scss,less} !**/{built,build}/** !**/reset.*ss'}

function _which {
  if [[ -n "$ZSH_VERSION" ]]; then
    builtin whence -p "$1"
  else
    builtin type -P "$1"
  fi
}

function _print_run {
  local DESC=$1; shift
  printf '\e[7m!~ %s (\e[4m%s\e[24m)\e[27m\r\n' "Running command '$*'" "$DESC"
  "$@"
  printf '\e[7m!! %s: \e[4m%s\e[24m\e[27m\r\n' "Exit code" "$?"
  printf '\e[7m!+ %s (\e[4m%s\e[24m)\e[27m\r\n' "Done running command '$*'" "$DESC"
}

readonly NPX=$(_which npx)
if [ -z "$NPX" ]; then
  echo "Node.js is not installed or not available in the PATH."
  exit 2
fi

# Run the `sass` preprocessor
if [ "x$RUN_SASS" = "x$YES" ]; then
  eval SASS_SRC=( $SASS_SOURCE )
  for src in ${SASS_SRC[@]}; do
    base_name=$(basename "$src")
    dir_name=$(dirname "$src")
    filename="${base_name%.*}"
    extension="${base_name##*.}"
    if [ -f "$src" ] && [[ "$filename" != _* ]]; then
      dst="$(dirname "$dir_name")/${CSS_COMPILED}/${extension}/${filename}.css"
      _print_run "SASS CSS preprocessor" "$NPX" sass --style=compressed --update "$src" "$dst"
    fi
  done
fi

# Run the `less` preprocessor
if [ "x$RUN_LESS" = "x$YES" ]; then
  eval LESS_SRC=( $LESS_MATCH )
  for src in ${LESS_SRC[@]}; do
    base_name=$(basename "$src")
    dir_name=$(dirname "$src")
    filename="${base_name%.*}"
    extension="${base_name##*.}"
    if [ -f "$src" ] && [[ "$filename" != _* ]]; then
      dst="$(dirname "$dir_name")/${CSS_COMPILED}/${extension}/${filename}.css"
      _print_run "LESS CSS preprocessor" "$NPX" lessc "$src" "$dst"
    fi
  done
fi

# Run the `stylelint` linter
if [ "x$RUN_STYLELINT" = "x$YES" ]; then
  _print_run "Stylelint CSS linter" "$NPX" stylelint --fix $STYLELINT_MATCH_PATTERN
fi

# Run the gulp tasks
if [ "x$RUN_GULP" = "x$YES" ]; then
  if [ "x$RUN_GULP_STYLES" = "x$YES" ]; then
    _print_run "gulp styles task" "$NPX" gulp styles
  fi
fi

# Run the `hint` linter
if [ "x$RUN_HINT" = "x$YES" ]; then
  _print_run "webhint HTML linter" "$NPX" hint "$PWD"
fi

if [ "x$RUN_LHCI" = "x$YES" ]; then
  _print_run "Lighthouse web auditor" "$NPX" lhci autorun --collect.staticDistDir="$PWD"
fi
