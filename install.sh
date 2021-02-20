#!/bin/zsh

# Default setting
ZSH=${ZSH:-~/.config/zsh}
ZSHREPO=${ZSHREPO:-guangl/zsh}
ZSHREMOTE=${ZSHREMOTE:-https://github.com/${ZSHREPO}.git}

VIMREPO=${VIMREPO:-guangl/nvim}
VIMREMOTE=${VIMREMOTE:-https://github.com/${VIMREPO}.git}

BRANCH=${BRANCH:-main}

# Default Path
ZSHRC=${ZSHRC:-~/.config/zsh}
VIMRC=${VIMRC:-~/.config/nvim}

command_exits() {
	command -v "$@" >/dev/null 2>&1
}

fmt_error() {
  echo ${RED}"Error: $@"${RESET} >&2
}

fmt_underline() {
  echo "$(printf '\033[4m')$@$(printf '\033[24m')"
}

fmt_code() {
  echo "\`$(printf '\033[38;5;247m')$@${RESET}\`"
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

setup_brew() {
	echo "${BLUE}Setup Brew..."

	command_exits brew &>/dev/null || {
		fmt_error "brew is not install"

		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>/dev/null || {
			fmt_error "install brew failed"
			exit 1
		}
	}

	echo "${BLUE}installing font cask..."

	brew tap homebrew/cask-fonts &>/dev/null || {
		fmt_error "install font cask failed"
		exit 1
	}

	echo "${BLUE}installing command line..."

	brew install git node pyenv fzf exa trash neovim &>/dev/null || {
		fmt_error "install command line failed"
		exit 1
	}

	echo "${BLUE}installing application..."

	brew install --cask alfred bartender devonthink google-chrome jetbrains-toolbox sketch wechat appcleaner downie iina motrix typora atext dash iterm2 pdf-expert visual-studio-code font-fira-code &>/dev/null  || {
		fmt_error "install application failed"
		exit 1
	}

	echo
}

setup_git() {
	echo "${BLUE}Setup Git..."

	command_exits git || {
		fmt_error "git is not install"

		brew install git &>/dev/null || {
			fmt_error "install git failed"
			exit 1
		}
	}

	echo
}

setup_zshrc() {
	echo "${BLUE}Setup ZSHRC..."

	git clone --depth=1 --branch "$BRANCH" "$ZSHREMOTE" "$ZSHRC" &>/dev/null || {
		fmt_error	"git clone failed"
	}

	ln ~/.config/zsh/init.zsh ~/.zshrc

	source ~/.zshrc

	echo
}

setup_vimrc() {
	echo "${BLUE}Setup VIMRC"

	git clone --depth=1 --branch "$BRANCH" "$VIMREMOTE" "$VIMRC" &>/dev/null || {
		fmt_error "git clone failed"
	}

	ln ~/.config/nvim/init.vim ~/.vimrc

	echo
}

main() {
	setup_color
	setup_brew
	setup_git
	setup_zshrc
	setup_vimrc
}

main "$@"
