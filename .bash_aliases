# My Modifications
# Commands when opening new terminal
PROMPT_DIRTRIM=3 # only show 3 directories
export PYTHONUSERBASE=$HOME/.local
export PATH=$PATH:$(pwd):$HOME/.local/bin
export QUOTING_STYLE=literal	#changes ls so no 'name space'
export PROMPT_COMMAND='history -a' #multiple terminals, save history
export HISTSIZE=1000    #save more history
HISTCONTROL=ignoredups      #ignore duplicates

#alias engr="ssh -X user@host.com"
alias cdsr="cd ~/Documents/Scripts/Scripts"
alias cdi3="cd ~/.config/i3/"
alias weather="cd ~/Documents/Arduino/Weather"
alias atmega="cd $(ls -t -d ~/Documents/Atmega328/*/ | head -1)"

#search history
alias hg="history | grep "

# stop terminal freezes/bell
stty -ixon
set bell-style none
#proper window checking
shopt -s checkwinsize
#cd dir with name
shopt -s autocd

#other aliases
if [ -f ~/.config/bash_hidden ]; then
    . ~/.config/bash_hidden
fi
