# Modifications - Commands when opening new terminal
PROMPT_DIRTRIM=3                    #only show 3 directories
export PYTHONUSERBASE=$HOME/.local
export PATH=$PATH:$(pwd):$HOME/.local/bin:$(ruby -e 'puts Gem.user_dir')/bin
export QUOTING_STYLE=literal	    #changes ls so no 'name space'
export PROMPT_COMMAND='history -a'  #multiple terminals, save history
export HISTSIZE=1000                #save more history
HISTCONTROL=ignoredups              #ignore duplicates

#alias svr="ssh -X user@host.com"
alias python='python3'      #default to python3
alias cdsr="cd ~/Documents/Scripts/Scripts"
alias cdi3="cd ~/.config/i3/"
alias weather="cd ~/Documents/Arduino/Weather"
alias atmega="cd $(ls -td ~/Documents/Projects/Atmega328/*/ | head -1)"
#avoid atmega directory
alias project="cd $(ls -td -I "Atmega328/" ~/Documents/Projects/*/ | head -1)"
alias reload_bash="source ~/.bashrc; echo 'Bash reloaded'"

alias hg="history | grep "      #search history

stty -ixon                      #stop terminal freeze
set bell-style none             #no bell
shopt -s checkwinsize           #proper window checking
shopt -s autocd                 #cd dir with name

#other aliases
if [ -f ~/.config/bash_hidden ]; then
    . ~/.config/bash_hidden
fi
