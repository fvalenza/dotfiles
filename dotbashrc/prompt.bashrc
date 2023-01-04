#!/bin/bash -i

# Personal Shell prompt. Surely needs some modifications or testing (solrized ?)

# https://stackoverflow.com/a/1862762 to display time of last executed command

# Cool Terminal prompt
_BOLD_ON=`tput bold`
_BOLD_OFF=`tput sgr0`
_RED="\[\033[0;31m\]"
_GREEN="\[\033[0;32m\]"
_YELLOW="\[\033[0;33m\]"
_BLUE="\[\033[0;34m\]"
_LIGHT_GRAY="\[\033[0;37m\]"
_LIGHT_MAGENTA="\[\033[0;95m\]"
_LIGHT_CYAN="\[\033[0;96m\]"
_RESET_COLOR="\e[0m"


function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop



__last_err() {
    [[ "$?" != "0" ]] && echo -ne "\e[1;31m!\e[0m "
}

export GIT_PS1_SHOWCOLORHINTS=1 GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch

# export PS1="${_GREEN}\u@${_LIGHT_MAGENTA}\H:${_LIGHT_CYAN}\w \$(__last_err)${_GREEN}${_BOLD_ON}\$(__git_ps1)\${_BOLD_OFF}\011${_LIGHT_GRAY}\${timer_show}s${_RESET_COLOR}\n─➤ "
export PS1="${_LIGHT_CYAN}\w \$(__last_err)${_GREEN}${_BOLD_ON}\$(__git_ps1)\${_BOLD_OFF}\011${_LIGHT_GRAY}\${timer_show}s${_RESET_COLOR}\n─➤ "
