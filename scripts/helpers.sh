#!/bin/sh
#
# Helper functions and constants to be used by the rest scripts

declare -rgA COLOURS=(
  [green]=$(tput setaf 2)
  [yellow]=$(tput setaf 3)
  [blue]=$(tput setaf 4)
  [red]=$(tput setaf 9)
  [default]=$(tput setaf 8)
)

function is_reply_positive() {
  if [[ $1 =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo 'true'
  else
    echo 'false'
  fi
}

function present_error() {
  echo ${COLOURS[red]}"Error:${COLOURS[default]} ${@}" 
}

function present_information() {
  echo ${COLOURS[yellow]}"Info:${COLOURS[default]} ${@}" 
}

function make_sure_xcode_is_installed() {
  xcode-select -p &> /dev/null
  if [ $? -ne 0 ]; then
    present_information "Xcode CLI tools not found. Installing them..."
    xcode-select --install
  fi
}

function total_files_in_directory() {
    echo $(ls ${@} | wc -l | awk {'print $1'})
}

function total_lines_in_file() {
  wc -l ${@} | awk {'print $1'}
}

function exit_if_brew_package_is_installed() {
  local brew_package=${@}
  local git_index=$(brew info --json=v1 --installed | jq  --arg brew_package "$brew_package" 'map(select(.installed != []) | .name) | index($brew_package)')

  if [[ $git_index =~ [0-9] ]]; then
    present_error "Brew package $brew_package is already installed."
    exit
  fi
}