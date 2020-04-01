#!/bin/sh
#
# Install node and npm with n

readonly CURRENT_DIRECTORY="$( cd "$(dirname ${0})" ; pwd -P )"
readonly HELPERS_PATH="${CURRENT_DIRECTORY}/helpers.sh"
readonly TEMPLATES_DIRECTORY="${PARENT_DIRECTORY}/templates"
readonly GITHUB_KEY_PATH="${HOME}/.ssh/github"

# Source dependencies
source ${HELPERS_PATH}

function take_ownership_of_system_directories() {
  # take ownership of node install destination folders
  sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
}

function install_node_and_npm() {
  n lts
}


function main(){
  make_sure_xcode_is_installed
  take_ownership_of_system_directories
  install_node_and_npm
}

main "$@"