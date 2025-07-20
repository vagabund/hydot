# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt auto_cd
setopt globdots
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
fpath+=(/usr/share/zsh/site-functions)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh   ] && source /usr/share/fzf/completion.zsh
zstyle ':completion:*' fzf-completion yes
zstyle ':fzf-tab:*'     fzf-command fzf --height=40% --border --reverse
compinit
# End of lines added by compinstall
eval "$(starship init zsh)"
