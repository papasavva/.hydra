#!/bin/sh
#
# Install brew casks and xcode cli tools if its not installed

readonly CURRENT_PATH="$( cd $(dirname ${0}) ; pwd -P )"
readonly PARENT_PATH="$(dirname ${CURRENT_PATH})"
readonly HELPERS_PATH="${CURRENT_PATH}/helpers.sh"
readonly CASKS_PATH="${PARENT_PATH}/brew/casks"

# Load depencies
source ${HELPERS_PATH}

function install_casks() {
  local readonly total_casks=$(total_lines_in_file ${CASKS_PATH} )
  local reply

  present_information "Total brew casks found: ${total_casks}"

  while IFS= read -r package; do
    echo -n "${COLOURS[red]}==>${COLOURS[default]} Do you want to install ${package}?${COLOURS[green]} "
    read reply </dev/tty

    if $(is_reply_positive "${reply}"); then
      brew cask install ${package}
      echo '\n'
    fi
  done < ${CASKS_PATH}
}

function exit_if_configuration_is_wrong() {
  if ! test -f ${CASKS_PATH}; then
    present_error 'Brew casks file not found.'
    exit
  elif
    ! test -s ${CASKS_PATH}; then 
    present_error 'Brew casks file is empty. Add one cask per line.'
    exit
  fi
}

function main(){
  make_sure_xcode_is_installed
  exit_if_configuration_is_wrong
  install_casks
}

main "$@"