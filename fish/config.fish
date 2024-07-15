if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

alias ls "eza --hyperlink --git --all" #--absolute
alias lst "eza --tree --recurse --level 2 --hyperlink --git --all" #--absolute
alias lsa "eza --tree --recurse --level 2 --hyperlink --long --header --links --inode --mounts --blocksize --total-size --modified --git --extended --all" #--absolute

# pokemon-colorscripts --no-title -r

starship init fish | source
