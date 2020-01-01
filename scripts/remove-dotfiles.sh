#!/bin/sh
#
# Unlink dotfiles found in templates folder

readonly CURRENT_DIRECTORY="$( cd "$(dirname ${0})" ; pwd -P )"
readonly PARENT_DIRECTORY="$(dirname $CURRENT_DIRECTORY)"
readonly TEMPLATES_DIRECTORY="${PARENT_DIRECTORY}/templates"

readonly HELPERS_PATH="${CURRENT_DIRECTORY}/helpers.sh"

# Source dependencies
source ${HELPERS_PATH}

function remove_dotfiles() {
  local dotfile_basename
  local dotfile_symlink_path

  for dotfile_template_path in "$TEMPLATES_DIRECTORY"/*; do
    dotfile_basename=$(basename ${dotfile_template_path})
    dotfile_symlink_path="${HOME}/.${dotfile_basename}"

    if test -f ${dotfile_symlink_path}; then
      unlink ${dotfile_symlink_path}
    fi
  done
}

function main(){
  remove_dotfiles
}

main "$@"