# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt autocd beep extendedglob nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/leo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

PATH=~/.local/bin/:$PATH

export FILES=/Files

setxkbmap -model pc105 -layout us,es -variant , -option grp:alt_shift_toggle

## Alias

alias postgres-start='sudo systemctl start postgresql.service'
alias mariadb-start='sudo systemctl start mariadb.service'

alias copy-keepass-pw='xclip -selection clipboard < /Files/Documents/Keepass/keepassxd-password.txt'

eval "$(starship init zsh)"

## Plugins

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#757480"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh