#!/bin/bash

function run {
	if ! pgrep $1 ;
	then
		$@&
	fi
}

run "picom" --no-fading-openclose
xsetwacom set "INGENIC Gadget Serial and keyboard" MapToOutput eDP-1
run "/usr/bin/emacs --daemon"
