#!/bin/sh
#
# Backup current dotfiles and then symlink with the templates

readonly CURRENT_DIRECTORY="$( cd "$(dirname ${0})" ; pwd -P )"
readonly PARENT_DIRECTORY="$(dirname $CURRENT_DIRECTORY)"
readonly TEMPLATES_DIRECTORY="${PARENT_DIRECTORY}/templates"
readonly HELPERS_PATH="${CURRENT_DIRECTORY}/helpers.sh"

# Source dependencies
source ${HELPERS_PATH}

function backup_files() {
  local dotfile_basename
  local dotfile_path

  for template in "$TEMPLATES_DIRECTORY"/*;  do
    dotfile_basename=$(basename ${template})
    dotfile_path="${HOME}/.${dotfile_basename}"

    if test -h ${dotfile_path}; then
      cp "${dotfile_path}" "${HOME}/.${dotfile_basename}.backup"
    fi
  done
}

function symlink_files() {
  local dotfile_basename
  local dotfile_symlink_path
  
  for dotfile_template_path in "${TEMPLATES_DIRECTORY}"/*; do  
    dotfile_basename=$(basename ${dotfile_template_path})
    dotfile_symlink_path="${HOME}/.${dotfile_basename}"

    if ! test -e ${dotfile_symlink_path}; then
      ln -s ${dotfile_template_path} ${dotfile_symlink_path}
    else
      present_error "file exists ${dotfile_template_path}"
    fi
  done
}

function exit_if_configuration_is_wrong() {
   total_files=$(total_files_in_directory ${TEMPLATES_DIRECTORY})

  if [ ${total_files} -eq 0 ]; then
    present_error 'No dotfile templates found.'
  fi
}

function main(){
  make_sure_xcode_is_installed
  exit_if_configuration_is_wrong
  backup_files
  symlink_files
}

main "$@"