source ~/.zsh/plugin-utils.zsh
autoload -U promptinit; promptinit
prompt pure
PROMPT='$(kube_ps1)'$PROMPT;kubeoff

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME

fc -RI

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fpath=(~/.zsh $fpath)

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_VIRTUALENV=/home/khanh/.local/bin/virtualenv

export PATH="$PATH:/home/khanh/.local/bin"

source ~/.local/bin/virtualenvwrapper.sh


export EDITOR=vim

[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh

# Load Angular CLI autocompletion.
source <(ng completion script)

# Load Kubernetes CLI autocompletion
source <(kubectl completion zsh)


alias dc="docker compose"
alias k="kubectl"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias grebase="git checkout develop && git pull && git checkout - && git rebase develop"
alias ls='eza'
alias d-rm-none='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

source ~/.workrc

