# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob
unsetopt beep

fpath+=~/.zfunc

alias ll='ls -laht'
alias bb='cat /sys/class/power_supply/BAT0/capacity'
alias rr='ranger'

export ANDROID_SDK_ROOT=~/Android/Sdk

export PATH=$PATH:$HOME/.cargo/bin

export EDITOR=vim

bindkey -v
bindkey "^R" history-incremental-search-backward
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jim/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit

prompt walters

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-envs
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-envs)"
    ssh-add
fi

source aws_zsh_completer.sh
