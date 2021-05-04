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
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.climate/bin

export EDITOR=vim

bindkey -v
bindkey "^R" history-incremental-search-backward
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jim/.zshrc'

autoload -Uz compinit promptinit
fpath+=~/.zfunc
compinit
promptinit

zstyle ':completion:*' menu select

prompt walters

alias grep='grep --color=auto'

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-envs
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-envs)"
    ssh-add
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export CUDA_VISIBLE_DEVICES=1

source ${HOME}/Software/zsh-z/zsh-z.plugin.zsh
