#!/bin/sh
#
# Install homebrew (https://brew.sh/)
# Requirements:
#   A 64-bit Intel CPU
#   macOS High Sierra (10.13) (or higher)
#   Command Line Tools (CLT) for Xcode: xcode-select --install, developer.apple.com/downloads or Xcode
#   A Bourne-compatible shell for installation (e.g. bash or zsh)

readonly CURRENT_PATH="$( cd $(dirname ${0}) ; pwd -P )"
readonly PARENT_PATH="$(dirname ${CURRENT_PATH})"
readonly HELPERS_PATH="${CURRENT_PATH}/helpers.sh"
readonly CASKS_PATH="${PARENT_PATH}/brew/casks"

# Load dependencies
source ${HELPERS_PATH}

function install_brew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

function exit_if_brew_is_already_installed() {
  which -s brew
  if [[ $? = 0 ]] ; then
    present_error 'Brew is already installed'
    exit
  fi
}

function main(){
  make_sure_xcode_is_installed
  exit_if_brew_is_already_installed
  install_brew
}

main "$@"