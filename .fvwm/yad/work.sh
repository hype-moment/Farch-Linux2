#!/bin/bash

desk=$(xdotool get_desktop)
ndesk=$(xdotool get_num_desktops)

set_prev(){
	[[ $(( $desk - 1 )) -lt 0 ]] && prev_=$(( $ndesk -1 )) \
								||  prev_=$(( $desk - 1 ))
	xdotool set_desktop $prev_
}

set_next(){
	xdotool set_desktop --relative 1
}

show(){
	echo $(( $desk + 1 ))
}

case $1 in
	Next) set_next 	;;
	Prev) set_prev 	;;
	Show) show
esac