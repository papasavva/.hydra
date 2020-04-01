# CONSTANTS
RED    := $(shell tput setaf 1)
GREEN  := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
BLUE   := $(shell tput setaf 6)
WHITE  := $(shell tput setaf 7)
RESET  := $(shell tput sgr0)

TARGET_MAX_CHAR_NUM:=20

default: help ;
.PHONY: packages casks brew git zsh dotfiles remove header help

## Install brew package manager
brew:
	@zsh ./scripts/brew.sh

## Configure git with github
git:
	@zsh ./scripts/git.sh

## Install packages with brew
packages:
	@zsh ./scripts/brew-packages.sh

## Install casks with brew
casks:
	@zsh ./scripts/brew-casks.sh

## Install node and npm with N
casks:
	@zsh ./scripts/node.sh

## Backup current dotfiles and symlink templates
dotfiles:
	@zsh ./scripts/dotfiles.sh

## Unlink current dotfiles
remove:
	@zsh ./scripts/remove-dotfiles.sh

header:
	@echo '${BLUE}'
	@echo '  _  ___   _____  ___    _   '
	@echo ' | || \ \ / /   \| _ \  /_\  '
	@echo ' | __ |\ V /| |) |   / / _ \ '
	@echo ' |_||_| |_| |___/|_|_\/_/ \_\'
	@echo -n '${GREEN}'
	@echo '      install and config apps';
	@echo -n '${RESET}'

## Show help
help: header
	@echo 'Usage:'
	@echo '  ${YELLOW}make ${GREEN}<target>'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\_0-9]+:/ { \
		help_explanation = match(last_line, /^## (.*)/); \
		if (help_explanation) { \
			help_target = substr($$1, 0, index($$1, ":")-1); \
			help_explanation = substr(last_line, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", help_target, help_explanation; \
		} \
	} \
	{ last_line = $$0 }' $(MAKEFILE_LIST)
	@echo '${GREEN}'
	@echo 'Sample:'
	@echo -n '${YELLOW}'
	@echo '  make help'