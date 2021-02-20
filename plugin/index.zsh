# 自动补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

# 建议
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting

# Theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Oh-My-Zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh


[ -f $HOME/.config/zsh/plugin/pyenv.zsh ] && source $HOME/.config/zsh/plugin/pyenv.zsh
[ -f $HOME/.config/zsh/plugin/p10k.zsh ] && source $HOME/.config/zsh/plugin/p10k.zsh
