#!/bin/zsh
config_path=$HOME/.config
vimrc=$HOME/.config/nvim/init.vim
vim_path='https://github.com/guangl/nvim.git'
zshrc=$HOME/.config/zsh/init.zsh
zsh_path='https://github.com/guangl/zsh.git'

command_exist() {
	exist=$(which $1)

	if [ $exist != 'not found' ]; then
		return 1
	else
		return 0
	fi
}

if command_exist git; then
	sudo cd "$config_path/zsh"
	if [ ! -e $zshrc ]; then
		sudo git clone $vim_path

		ln $vim_path "$HOME/.zshrc"
	fi

	if [ ! -e $vimrc ]; then
		sudo git clone $vim_path
	fi
fi
