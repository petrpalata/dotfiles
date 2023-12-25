# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '' 'l:|=* r:|=*' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
autoload -U colors && colors
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory autocd extendedglob
unsetopt beep nomatch notify
bindkey -e



# End of lines configured by zsh-newuser-install

system=`uname`
if  [[ $system = "Darwin" ]]; then  # mac specific settings
    alias ls='ls -G'
    export PATH=/opt/homebrew/opt/python/libexec/bin:$PATH
    export PATH=/opt/homebrew/bin:/opt/local/bin:/opt/local/sbin:$PATH
else
    alias ls='ls --color'
fi

local blue_op="%{$fg[red]%}[%{$reset_color%}"
local blue_cp="%{$fg[red]%}]%{$reset_color%}"
local path_p="%{$fg[yellow]%}%~%{$reset_color%}"
local time_p="%{$fg[white]%}%{$bg[green]%}%*%{$reset_color%}"
local user_host="${blue_op}%n@%m${blue_cp}"
PROMPT='╭─${blue_op}${path_p}${blue_cp}─${user_host}$(git_status_prompt)
╰─%# '
local cur_cmd="${blue_op}%_${blue_cp}"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

PATH=$PATH:/usr/local/sbin

set -o vi # use vi command line mode
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M viins '^R' history-incremental-search-backward

# RBENV configuration
export RBENV_ROOT=/opt/homebrew/var/rbenv # use homebrew directories
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # enable shims

# Git command line status
source ~/.zsh_git_prompt/zsh_git_prompt.sh

function git_status_prompt() {
  local git_status
  local super_status=$(git_super_status)
  if [[ -z $super_status ]]; then
     git_status=""
  else 
     git_status="-%b${super_status}"
  fi
  echo $git_status
}


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

powerline-daemon -q

source /opt/homebrew/lib/python3.9/site-packages/powerline/bindings/zsh/powerline.zsh

# alias
source ~/.zshalias

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export EDITOR=nvim
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
