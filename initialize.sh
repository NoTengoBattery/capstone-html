#!/bin/bash
# If you feel the need to criticize this script, please note that it
# is an ad-hoc solution for an ad-hoc problem with little to no
# scalability.

if [ -z "$BASH_VERSION" -a -z "$ZSH_VERSION" ]; then
  echo "Please use a BASH-like shell to run this script."
  exit 1
fi
if [ ! -e .rootholder ]; then
  echo "Please run this inside the root folder of an uninitialized project."
  exit 1
fi

function _which {
  if [[ -n "$ZSH_VERSION" ]]; then
    builtin whence -p "$1"
  else
    builtin type -P "$1"
  fi
}

readonly NPM=$(_which npm)
if [ -z "$NPM" ]; then
  echo "Node.js is not installed or not available in the PATH."
  exit 2
fi

"$NPM" install # This will install all the Node.js dependencies
if [ $? -eq 0 ]; then
  echo "All dependencies installed successfully."
else
  echo "Failed to install all dependencies."
  exit 3
fi
"$NPM" update
"$NPM" audit fix

readonly GIT=$(_which git)
if [ -z "$GIT" ]; then
  echo "Git is not installed or not available in the PATH."
  echo "You really, really want GIT in your PATH."
  exit 4
fi

readonly CURL=$(_which curl)
if [ -z "$CURL" ]; then
  echo "cURL is not installed or not available in the PATH."
  echo "You really, really want cURL in your PATH."
  exit 5
fi

# Grab the configuration files
readonly LC='https://raw.githubusercontent.com/microverseinc/linters-config/master/html-css'
readonly RT='https://raw.githubusercontent.com/microverseinc/readme-template/master'
"$CURL" $LC/.hintrc -o .hintrc -s
"$CURL" $LC/.stylelintrc.json -o .stylelintrc.json -s
"$CURL" $LC/.github/workflows/linters.yml -o .github/workflows/linters.yml -s
mv -f README.md README.md.old
"$CURL" $RT/README.md -o README.md -s
"$CURL" https://unpkg.com/reset-css/less/reset.less -o src/less/reset.less -s -L

find . \( -name '.placeholder' -o -name '.rootholder' \) -a -type f -delete
$SHELL tasks.sh

"$GIT" init
"$GIT" add .
"$GIT" commit -m "project: initialize the project"

echo "Done!"
exit 0
