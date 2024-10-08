#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:

declare -A URLS

URLS=(
  ["devdocs"]="https://devdocs.io/"
  ["google"]="https://www.google.com/search?q="
  ["bing"]="https://www.bing.com/search?q="
  ["yahoo"]="https://search.yahoo.com/search?p="
  ["duckduckgo"]="https://www.duckduckgo.com/?q="
  ["github"]="https://github.com/search?q="
  ["stackoverflow"]="http://stackoverflow.com/search?q="
  ["searchcode"]="https://searchcode.com/?q="
  ["youtube"]="https://www.youtube.com/results?search_query="
  ["twitch"]="https://twitch.tv/"
  ['libgen']="https://libgen.is/search.php?&req="
  ["annasarchive"]="https://annas-archive.gs/search?q="
  ["wikipedia"]="https://en.wikipedia.org/wiki/"
  # ["yandex"]="https://yandex.ru/yandsearch?text="
  # ["goodreads"]="https://www.goodreads.com/search?q="
  # ["symbolhound"]="http://symbolhound.com/?q="
  # ["openhub"]="https://www.openhub.net/p?ref=homepage&query="
  # ["superuser"]="http://superuser.com/search?q="
  # ["askubuntu"]="http://askubuntu.com/search?q="
  # ["imdb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q="
  # ["rottentomatoes"]="https://www.rottentomatoes.com/search/?search="
  # ["piratebay"]="https://thepiratebay.org/search/"
  # ["vimawesome"]="http://vimawesome.com/?q="
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}

main() {
  # Pass the list to rofi
  platform=$( (gen_list) | rofi -dmenu -matching fuzzy -no-custom -location 0 -p "Search > " )

  if [[ -n "$platform" ]]; then
    query=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Query > " )

    if [[ -n "$query" ]]; then
      url=${URLS[$platform]}$query
      xdg-open "$url"
    else
      exit
    fi

  else
    exit
  fi
}

main

exit 0
