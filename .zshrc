eval "$(/opt/homebrew/bin/brew shellenv)"
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export CLICOLOR=1

typeset -U path
path=( $HOMEBREW_PREFIX/opt/libpq/bin $path )

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_FIND_NO_DUPS

bindkey -v

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey -M vicmd v edit-command-line

alias v=nvim

j() { jq -C "${2:-.}" "$1" | less -R }

venv() {
  local dir=$PWD venv

  while [[ $dir != / ]]; do
    [[ -x $dir/.venv/bin/python ]] && { venv=$dir/.venv; break; }
    dir=${dir:h}
  done

  [[ $VIRTUAL_ENV == $venv && ( -z $venv || $path[1] == $venv/bin ) ]] && return

  [[ -n $VIRTUAL_ENV ]] && path=(${path:#"$VIRTUAL_ENV/bin"})
  unset VIRTUAL_ENV VIRTUAL_ENV_PROMPT

  if [[ -n $venv ]]; then
    export VIRTUAL_ENV=$venv
    path=($venv/bin ${path:#"$venv/bin"})
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd venv
venv

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh --disable-up-arrow)"
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
