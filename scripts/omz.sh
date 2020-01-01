#!/bin/sh
#
# Install brew casks and xcode cli tools if its not installed

readonly CURRENT_DIRECTORY="$( cd "$(dirname ${0})" ; pwd -P )"

readonly HELPERS_PATH="${CURRENT_DIRECTORY}/helpers.sh"
readonly OH_MY_ZSH_PATH="${HOME}/.oh-my-zsh"

# Source dependencies
source ${HELPERS_PATH}

function install_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function exit_if_oh_my_zsh_is_installed() {
  if test -e "${OH_MY_ZSH_PATH}"; then
    present_error "OH MY ZSH is already installed."
    exit
  fi
}

function main(){
  make_sure_xcode_is_installed
  exit_if_oh_my_zsh_is_installed
  install_zsh
}

main "$@"