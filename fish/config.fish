if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

alias ls "eza --hyperlink --git --all" #--absolute
alias lst "eza --tree --recurse --level 2 --hyperlink --git --all" #--absolute
alias lsa "eza --tree --recurse --level 2 --hyperlink --long --header --links --inode --mounts --blocksize --total-size --modified --git --extended --all" #--absolute

alias cdc "cd ~/.config/"
alias cds "cd /mnt/share/"

alias emacs "emacsclient -c -a 'emacs'"
# pokemon-colorscripts --no-title -r

starship init fish | source

set -gx EDITOR nvim

# Created by `pipx` on 2024-07-18 03:06:41
set PATH $PATH /home/hshen2908/.local/bin
set PATH $PATH ~/.config/emacs/bin
