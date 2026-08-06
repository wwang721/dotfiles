# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export COLORTERM=truecolor

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# DO NOT EDIT THE TOP OF THIS FILE OR YOU WILL BREAK YOUR ACCOUNT. PUT CHANGES AT THE BOTTOM
# export PS1='\[\e[01;31m\][\[\e[01;36m\]\u\[\e[01;33m\]@\[\e[01;35m\]\h\[\e[01;31m\]]:\[\e[01;34m\]\w\[\e[01;32m\]\$ \[\e[0m\]'
export PS1='\[\e[01;32m\]${CONDA_DEFAULT_ENV:+($CONDA_DEFAULT_ENV)}\[\e[01;31m\][\[\e[01;36m\]\u\[\e[01;33m\]@\[\e[01;35m\]\h\[\e[01;31m\]]:\[\e[01;34m\]\w\[\e[01;32m\]\$ \[\e[0m\]'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Only switch to zsh if this is an interactive shell
if [[ $- == *i* ]] && [[ -t 0 ]] && command -v zsh >/dev/null 2>&1 && [ -z "$ZSH_VERSION" ]; then
  exec zsh
fi

alias cmy='conda activate myenv'
alias view='nvim -R'
alias bat='bat --paging=never'

# fzf
export PATH="$HOME/.fzf/bin:$PATH"
source ~/.fzf/shell/key-bindings.bash
source ~/.fzf/shell/completion.bash


# Options to fzf command
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --border --info=inline"


#========================================================================
# Use fd in fzf
#------------------------------------------------------------------------
# Use fd for fzf's common UI: fzf or $(fzf)
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git --exclude .ipynb_checkpoints'

# Use fd for fzf's CTRL-T: list files + directories
export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git --exclude .ipynb_checkpoints'

# Use fd for fzf's ALT-C: list directories only
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude .ipynb_checkpoints'

# Use fd for fzf **<TAB> completion (paths/files)
_fzf_compgen_path() {
  fd --hidden --follow --exclude .git --exclude .ipynb_checkpoints . "$1"
}
# Use fd for fzf **<TAB> completion (directories)
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git --exclude .ipynb_checkpoints . "$1"
}
#========================================================================


# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments ($@) to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}



# User specific aliases and functions
module load gcc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/data/apps/extern/spack_on/gcc/9.3.0/miniconda3/22.11.1-7f5s6r5uqyngliaca4moeawkxnnsmwkq/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/data/apps/extern/spack_on/gcc/9.3.0/miniconda3/22.11.1-7f5s6r5uqyngliaca4moeawkxnnsmwkq/etc/profile.d/conda.sh" ]; then
        . "/data/apps/extern/spack_on/gcc/9.3.0/miniconda3/22.11.1-7f5s6r5uqyngliaca4moeawkxnnsmwkq/etc/profile.d/conda.sh"
    else
        export PATH="/data/apps/extern/spack_on/gcc/9.3.0/miniconda3/22.11.1-7f5s6r5uqyngliaca4moeawkxnnsmwkq/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


