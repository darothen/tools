# ============================================================== #
#
# PERSONAL BASH/CONFIG ($HOME/.bashrc)
#
# Last modified: Tuesday, July 29, 2014
# Author: Daniel Rothenberg <darothen@mit.edu>
#
# This configuration file is the stub I use to modify my working environment
# on *nix systems. Some of the particular PATH modfications may need to be
# altered depending on where the script is ported, but anything after the 
# user-configuration section should be fine.
#
# with inspiration from:
#     - http://www.tldp.org/LDP/abs/html/sample-bashrc.html
#
# ============================================================== #

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

## Begin setting up PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin

## Add Anaconda to Path
export PATH=/Users/daniel/anaconda/bin:$PATH
# To enable QT support, switch the default qt backend for matplotlib
# to PySide with this environment flag
export QT_API=pyside
## Add personal research tools to Path
export PYTHONPATH=$PYTHONPATH:/Users/daniel/workspace/python_libs:/Users/daniel/workspace/Research

## Add GSL and other libraries to dynamic loader
#export DYLD_LIBRARY_PATH=/usr/local/lib:$DYLD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

## Add DAKOTA to Path
#export PATH=$PATH:/Users/daniel/dakota/bin:/Users/daniel/dakota/test
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/daniel/dakota/bin:/Users/daniel/dakota/lib

# ============================================================== #
#
# Further modifications should not be necessary after here
#
# ============================================================== #

# Before anything else, detect platform:

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform="mac"
fi

# -------------------------------------------------------------- #
# Aliases

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'
alias ll="ls -lth"
alias la="ls -a"
alias lr="ls -ltrh"
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias ..='cd ..'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

alias c="clear"
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias grep="grep --color=auto"
alias tf="tail -n 500 -f"

alias git=hub # wrapper for GitHub
alias em="emacs -nw"
alias md="/Applications/MacDown.app/Contents/MacOS/MacDown"

if [[ $platform == 'linux' ]]; then
    alias ls='ls --color=auto'
else 
    alias ls="ls -G"
fi



# -------------------------------------------------------------- #
# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
Gray='\e[0;37m'

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

# -------------------------------------------------------------- #
# Terminal config/info/MOTD

case $TERM in
    xterm*)
        TITLEBAR='\[\033]0;\u@\h:\w\007'
        ;;
    *)
        TITLEBAR=""
        ;;
esac


date
if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s     # Makes our day a bit more fun.... :-)
fi

# -------------------------------------------------------------- #
# Shell prompt
#-------------------------------------------------------------
# Current Format: [TIME USER@HOST PWD] >
# TIME:
#    Green     == machine load is low
#    Orange    == machine load is medium
#    Red       == machine load is high
#    ALERT     == machine load is very high
# HOST:
#    Cyan      == local session
#    Green     == secured remote connection (via ssh)
#    Red       == unsecured remote connection
# PWD:
#    Green     == more than 10% free disk space
#    Orange    == less than 10% free disk space
#    ALERT     == less than 5% free disk space
#    Red       == current user does not have write privileges
#    Cyan      == current filesystem is size zero (like /proc)
# >:
#    White     == no background or suspended jobs in this shell
#    Cyan      == at least one background job in this shell
#    Orange    == at least one suspended job in this shell
#
#    Command is added to the history file each time you hit enter,
#    so it's available to all shells (using 'history -a').

# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
    CNX=${Green}        # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
    CNX=${ALERT}        # Connected on remote machine, not via ssh (bad).
else
    CNX=${BCyan}        # Connected on local machine.
fi

# System load:
if [[ $platform == 'mac' ]]; then
    NCPU=$(sysctl hw.ncpu | awk '{print $2}')
else 
    NCPU=$(grep -c 'processor' /proc/cpuinfo)    # Number of CPUs
fi
SLOAD=$(( 100*${NCPU} ))        # Small load
MLOAD=$(( 200*${NCPU} ))        # Medium load
XLOAD=$(( 400*${NCPU} ))        # Xlarge load

# Returns system load as percentage, i.e., '40' rather than '0.40)'.
function load()
{
    if [[ $platform == 'mac' ]]; then
        SYSLOAD=$(sysctl -n vm.loadavg | cut -d" " -f2)
    else 
        SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
    fi
    
    # System load of the current host.
    echo "$((100 # ${SYSLOAD} ))"    # Convert to decimal.
}

# Returns a color indicating system load.
function load_color()
{
    local SYSLOAD=$(load)
    echo "|" $(load) "|" $SYSLOAD $XLOAD $MLOAD $SLOAD
    if [ ${SYSLOAD} -gt ${XLOAD} ]; then
        echo -en ${ALERT}
    elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
        echo -en ${Red}
    elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
        echo -en ${BRed}
    else
        echo -en ${Green}
    fi
}

# Returns a color according to running/suspended jobs.
function job_color()
{
    if [ $(jobs -s | wc -l) -gt "0" ]; then
        echo -en ${BRed}
    elif [ $(jobs -r | wc -l) -gt "0" ] ; then
        echo -en ${BCyan}
    fi
}

time_fmt="$Blue[\$(load_color)\][\A\[${NC}$Blue]"

## NEW
PROMPT_COMMAND="history -a"
# case ${TERM} in
#   *term | rxvt | linux)
#         # Time of day (with load info):
#         PS1="\[\$(load_color)\][\A\[${NC}\] "
#         # User@Host (with connection type info):
#         #PS1=${PS1}"\[${SU}\]\u\[${NC}\]@\[${CNX}\]\h\[${NC}\] "
#         # PWD (with 'disk space' info):
#         #PS1=${PS1}"\[\$(disk_color)\]\W]\[${NC}\] "
#         # Prompt (with 'job' info):
#         PS1=${PS1}"\[\$(job_color)\]>\[${NC}\] "
#         # Set title of current xterm:
#         PS1=${PS1}"\[\e]0;[\u@\h] \w\a\]"
#         ;;
#     *)
#         PS1="(\A \u@\h \W) > " # --> PS1="(\A \u@\h \w) > "
#                                # --> Shows full pathname of current dir.
#         ;;
# esac

## OLD
PS1="${TITLEBAR}\
\[$Blue\][\[$Red\]\$(date +%H%M)\[$Blue\]]\
 \[$BWhite\]\u\[$Red\]@\[$BBlue\]\h:\[$Cyan\]\w\
\[$Gray\]$ "
PS2='> '
PS4='+ '

## Remote Connection Aliases
# newton (Singapore)
export NEWTON=203.125.133.98
export NEWTON_PORT=22003
alias sshnewton="ssh -Y -p $NEWTON_PORT darothen@$NEWTON"
scpnewton() {
    echo -e "Copying $1 to $NEWTON:$2\n"
    scp -P $NEWTON_PORT $1 darothen@$NEWTON:$2
}


## Finally, make sure user-defined programs appear first in path
export PATH=/Users/daniel/bin:/usr/local/bin:$PATH
