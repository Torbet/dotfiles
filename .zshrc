export CLICOLOR=1

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

bindkey -v

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

alias v="nvim"

autoload -Uz add-zsh-hook

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

add-zsh-hook chpwd venv
venv

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit

eval "$(starship init zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
