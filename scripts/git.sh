#!/bin/sh
#
# Make sure git is installed and configure it for gitlab

readonly CURRENT_DIRECTORY="$( cd "$(dirname ${0})" ; pwd -P )"
readonly HELPERS_PATH="${CURRENT_DIRECTORY}/helpers.sh"
readonly TEMPLATES_DIRECTORY="${PARENT_DIRECTORY}/templates"
readonly GITLAB_KEY_PATH="${HOME}/.ssh/gitlab_rsa"

# Source dependencies
source ${HELPERS_PATH}

function config_git() {
  git config --global user.name "Alexandros P."
  git config --global user.email "papasavva@protonmail.com"
}

function create_gitlab_authentication_key() {
  # Using ed25519 digital signature as is more safe than RSA (https://docs.gitlab.com/ee/ssh/#ed25519-ssh-keys)
  ssh-keygen -t ed25519 -f ~/.ssh/gitlab_rsa -C "gitlab_rsa"

  eval "$(ssh-agent -s)"
  ssh-add -K ${GITLAB_KEY_PATH}
  pbcopy < "${GITLAB_KEY_PATH}.pub"

  present_information 'Gitlab SSH key is copied to your clipboard. You must add it on your Gitlab account.'
}

function list_all_ssh_keys() {
    present_information 'Current SSH Keys'
    for key in ~/.ssh/*_rsa; do ssh-keygen -l -f "${key}"; done | uniq
    present_information 'Consider replacing ssh keys with Ed25519 algorithm'

}
function exit_if_gitlab_authentication_key_exists() {
  echo ${GITLAB_KEY_PATH}
  if test -f ${GITLAB_KEY_PATH}; then
    present_error "Gitlab authentication key already exists."
    exit
  fi
}

function main(){
  make_sure_xcode_is_installed
  exit_if_gitlab_authentication_key_exists
  config_git
  create_gitlab_authentication_key
  list_all_ssh_keys
}

main "$@"