#! /usr/bin/env zsh
#
# Install brew packages and xcode cli tools if its not installed

readonly CURRENT_PATH="$( cd $(dirname ${0}) ; pwd -P )"
readonly PARENT_PATH="$(dirname ${CURRENT_PATH})"
readonly HELPERS_PATH="${CURRENT_PATH}/helpers.sh"
readonly PACKAGES_PATH="${PARENT_PATH}/brew/packages"

# Load depencies
source ${HELPERS_PATH}

function install_packages() {
  local readonly total_packages=$(total_lines_in_file ${PACKAGES_PATH} )
  local reply

  present_information "Total brew packages found: ${total_packages}"

  while IFS= read -r package; do
    echo -n "${COLOURS[red]}==>${COLOURS[default]} Do you want to install ${package}?${COLOURS[green]} "
    read reply </dev/tty

    if $(is_reply_positive "${reply}"); then
      brew install ${package}
      echo '\n'
    fi
  done < ${PACKAGES_PATH}
}

function exit_if_configuration_is_wrong() {
  if ! test -f ${PACKAGES_PATH}; then
    present_error 'Brew packages file not found.'
    exit
  elif
    ! test -s ${PACKAGES_PATH}; then 
    present_error 'Brew packages file is empty. Add one package per line.'
    exit
  fi
}

function main(){
  make_sure_xcode_is_installed
  exit_if_configuration_is_wrong
  install_packages
}

main "$@"