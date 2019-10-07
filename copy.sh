#!/bin/bash
#backup t-time r-recursive h-human readable l-links (no-links for no soft links) v-verbose
#--modify-window reduce accuracy --progress shows file transfer n=dry run
dotfiles="$HOME/"
scriptfiles="$HOME/Documents/Scripts/Scripts"
gh_dotfiles="$scriptfiles/Github_Dotfiles"
gh_scriptfiles="$gh_dotfiles/Scripts"

#include backup script
backup="rsync -avh \
   --exclude-from=$gh_dotfiles/copy_exclude"

#backup dotfiles
echo "-------------Dot files------------"
eval $backup "--recursive  --include-from=$gh_dotfiles/copy_include" $dotfiles $gh_dotfiles

#backup scripts
echo "-------------Scripts--------------"
eval $backup "--include-from=$gh_dotfiles/copy_include" "$scriptfiles/" $gh_scriptfiles

