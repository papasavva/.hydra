#!/usr/bin/env zsh
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