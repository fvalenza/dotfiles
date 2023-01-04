#!/bin/bash -i

# Personal Shell prompt. Surely needs some modifications or testing (solrized ?)

# Cool Terminal prompt
_BOLD_ON=`tput bold`
_BOLD_OFF=`tput sgr0`
_RED="\[\033[0;31m\]"
_GREEN="\[\033[0;32m\]"
_YELLOW="\[\033[0;33m\]"
_BLUE="\[\033[0;34m\]"
_LIGHT_MAGENTA="\[\033[0;95m\]"
_LIGHT_CYAN="\[\033[0;96m\]"
_RESET_COLOR="\e[0m"

__last_err() {
    [[ "$?" != "0" ]] && echo -ne "\e[1;31m!\e[0m "
}
export GIT_PS1_SHOWCOLORHINTS=1 GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch

export PS1="${_GREEN}\u@${_LIGHT_MAGENTA}\h:${_LIGHT_CYAN}\w \$(__last_err)${_GREEN}${_BOLD_ON}\$(__git_ps1)\${_BOLD_OFF}\n─➤ "


#if [[ ${EUID} == 0 ]] ; then
#PS1='\e[1;31;48;5;234m\u \e[38;5;240mon \e[1;38;5;28;48;5;234m\h \e[38;5;54m\d \@\e[0m\n\e[0;31;48;5;234m[\w] \e[1m\$\e[0m '
#else
#PS1='\e[1;38;5;56;48;5;234m\u \e[38;5;240mon \e[1;38;5;28;48;5;234m\h \e[38;5;54m\d \@\e[0m\n\e[0;38;5;56;48;5;234m[\w] \e[1m\$\e[0m '
#fi
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

