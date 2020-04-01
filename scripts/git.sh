#!/bin/sh
#
# Make sure git is installed and configure it for github

readonly CURRENT_DIRECTORY="$( cd "$(dirname ${0})" ; pwd -P )"
readonly HELPERS_PATH="${CURRENT_DIRECTORY}/helpers.sh"
readonly TEMPLATES_DIRECTORY="${PARENT_DIRECTORY}/templates"
readonly GITHUB_KEY_PATH="${HOME}/.ssh/github"

# Source dependencies
source ${HELPERS_PATH}

function install_git() {
  brew install git
}

function config_git() {
  git config --global user.name "Alexandros Papasavva"
  git config --global user.email "papasavva.alexandros@gmail.com"
}

function create_github_authentication_key() {
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/github_rsa -C "github_rsa papasavva.alexandros@gmail.com"

  eval "$(ssh-agent -s)"
  ssh-add -K ${GITHUB_KEY_PATH}
  pbcopy < ${GITHUB_KEY_PATH}

  present_information 'Github SSH key is copied to your clipboard. You must add it on Github.'
}

function exit_if_github_authentication_key_exists() {
  echo ${GITHUB_KEY_PATH}
  if test -f ${GITHUB_KEY_PATH}; then
    present_error "Github authentication key already exists."
    exit
  fi
}

function main(){
  make_sure_xcode_is_installed
  exit_if_brew_package_is_installed "git"
  install_git
  exit_if_github_authentication_key_exists
  config_git
  create_github_authentication_key
}

main "$@"