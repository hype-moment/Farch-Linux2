#!/bin/bash

BORDERS_RADIUS(){
Value=$(cat ~/.fvwm/picom.conf | grep corner-radius | sed 's/.*= //g;s/;//g')
YAD=$(pkill yad
		yad --scale --posx=46 --posy=37 --image=$HOME/.fvwm/yad/Pop_Icons/radius.png \
			--width=300 --inc-buttons --min-value=1 --max-value=12 --value="$Value" )
	  	
	for i in "$YAD"; do
		
		if [[ "$i" > "0" ]];then
			sed -i "s/corner-radius.*/corner-radius = $i;/g" ~/.fvwm/picom.conf
		fi
	done 
}

CALENDAR(){
	pkill yad
	yad --calendar --posx=50 --posy=693 \
		--width=400 \
		--no-buttons 
}


FRAME_TRANSPARENCE(){
Value=$(cat ~/.fvwm/picom.conf | grep frame-opacity | awk '{print $3}' | sed 's/.*\.//g;s/;//g')
YAD=$(pkill yad
	  yad --scale --posx=46 --posy=76 \
		  --image=$HOME/.fvwm/yad/Pop_Icons/frame.png \
		  --width=300 --inc-buttons --min-value=1 --max-value=99 --value="$Value")

	for i in "$YAD"; do
		if [[ $i > 0 ]];then
			sed -i "s/frame-opacity = 0.*/frame-opacity = 0.$i;/g" ~/.fvwm/picom.conf
		fi
	done 
}

THEME_MODE(){
Alfa=$(cat ~/.config/tint2/tools.tint2rc | grep "background_color =" | awk '{print $4}')
	pkill yad
	yad --posx=46 --posy=115 --image=$HOME/.fvwm/yad/Pop_Icons/theme-mode.png \
		--fixed --buttons-layout=center \
		--button="Dark !$HOME/.fvwm/yad/Icons/dark.png":1 \
		--button="Light !$HOME/.fvwm/yad/Icons/light.png":2 \

foo=$?

if [[ $foo -eq 1 ]]; then
sed -i 's/gtk-theme-name=.*/gtk-theme-name=Midnight/g' ~/.config/gtk-3.0/settings.ini
sed -i 's/Colorset 2 bg.*/Colorset 2 bg #121212/g' ~/.fvwm/functions/window_decorrc
sed -i 's/gtk-theme-name=.*/gtk-theme-name="Midnight"/g' ~/.gtkrc-2.0
sed -i 's/Mini-menu-.*/Mini-menu-dark.rasi -show drun/g' ~/.config/tint2/tools.tint2rc
sed -i "s/background_color = .*/background_color = #121212 "$Alfa"/g" ~/.config/tint2/tools.tint2rc
sed -i "s/border_color .*/border_color = #F5F5F5 "$Alfa"/g" ~/.config/tint2/tools.tint2rc
sed -i "s/background_color = .*/background_color = #121212 "$Alfa"/g" ~/.config/tint2/tint2rc
sed -i "s/border_color .*/border_color = #F5F5F5 "$Alfa"/g" ~/.config/tint2/tint2rc
pkill tint2
tint2 & tint2 -c ~/.config/tint2/tools.tint2rc

elif [[ $foo -eq 2 ]]; then
sed -i 's/gtk-theme-name=.*/gtk-theme-name=Midday/g' ~/.config/gtk-3.0/settings.ini
sed -i 's/Colorset 2 bg.*/Colorset 2 bg #F5F5F5/g' ~/.fvwm/functions/window_decorrc
sed -i 's/gtk-theme-name=.*/gtk-theme-name="Midday"/g' ~/.gtkrc-2.0
sed -i 's/Mini-menu-.*/Mini-menu-white.rasi -show drun/g' ~/.config/tint2/tools.tint2rc
sed -i "s/background_color = .*/background_color = #F5F5F5 "$Alfa"/g" ~/.config/tint2/tools.tint2rc
sed -i "s/border_color .*/border_color = #121212 "$Alfa"/g" ~/.config/tint2/tools.tint2rc
sed -i "s/background_color = .*/background_color = #F5F5F5 "$Alfa"/g" ~/.config/tint2/tint2rc
sed -i "s/border_color .*/border_color = #121212 "$Alfa"/g" ~/.config/tint2/tint2rc
pkill tint2
tint2 & tint2 -c ~/.config/tint2/tools.tint2rc 

fi
}

POSITION(){
	pkill yad
	yad --posx=46 --posy=153 --buttons-layout=center \
		--fixed --image=$HOME/.fvwm/yad/Pop_Icons/window-position.png \
		--button="Left !$HOME/.fvwm/yad/Icons/left.png":1 \
		--button="Top !$HOME/.fvwm/yad/Icons/top.png":2 \
		--button="Right !$HOME/.fvwm/yad/Icons/right.png":3 \
		--button="Bottom !$HOME/.fvwm/yad/Icons/bottom.png":4 \

foo=$?

if [[ $foo -eq 1 ]]; then
sed -i 's/TitleAt.*/TitleAtLeft/g' ~/.fvwm/functions/window_decorrc && exit 0

elif [[ $foo -eq 2 ]]; then
sed -i 's/TitleAt.*/TitleAtTop/g' ~/.fvwm/functions/window_decorrc && exit 0

elif [[ $foo -eq 3 ]]; then
sed -i 's/TitleAt.*/TitleAtRight/g' ~/.fvwm/functions/window_decorrc && exit 0

elif [[ $foo -eq 4 ]]; then
sed -i 's/TitleAt.*/TitleAtBottom/g' ~/.fvwm/functions/window_decorrc && exit 0

fi
}

SET_COLOR(){
	Value=$(cat ~/.fvwm/functions/window_decorrc | grep Tint | awk '{print $2}')
YAD=$(pkill yad
      yad --posx=46 --posy=193 --image=$HOME/.fvwm/yad/Pop_Icons/colors.png \
		  --init-color=$Value --color --gtk-palette --fixed)

	for i in "$YAD"; do
		if [[ $i > 0 ]];then
			sed -i "s/Tint .*/Tint $i 100/g" ~/.fvwm/functions/window_decorrc
		fi
	done 
}

SET_ICONS(){
	pkill yad	
	yad --posx=46 --posy=232 --image=$HOME/.fvwm/yad/Pop_Icons/window-icons.png \
		--fixed --buttons-layout=center \
		--button="Blocks":1 \
		--button="Cicles":2 \
		--button="W10":3 \
		--button="MacOS":4 \
		--button="Classic":5 \
		--button="Simple":6 \

foo=$?

if [[ $foo -eq 1 ]]; then
sed -i 's/icons\/.*/icons\/blocks/g' ~/.fvwm/config && exit 0

elif [[ $foo -eq 2 ]]; then
sed -i 's/icons\/.*/icons\/circles/g' ~/.fvwm/config && exit 0

elif [[ $foo -eq 3 ]]; then
sed -i 's/icons\/.*/icons\/w10/g' ~/.fvwm/config && exit 0

elif [[ $foo -eq 4 ]]; then
sed -i 's/icons\/.*/icons\/macos/g' ~/.fvwm/config && exit 0

elif [[ $foo -eq 5 ]]; then
sed -i 's/icons\/.*/icons\/classic/g' ~/.fvwm/config

elif [[ $foo -eq 6 ]]; then
sed -i 's/icons\/.*/icons\/wcircles/g' ~/.fvwm/config	

fi
}

PRINT(){
	pkill yad
	yad --posx=46 --posy=270 --buttons-layout=center \
		--fixed  --image=$HOME/.fvwm/yad/Pop_Icons/screenshot.png \
		--button="!$HOME/.fvwm/yad/Icons/shot.png":1 \
		--button="!$HOME/.fvwm/yad/Icons/cut.png":2 \
		--button="!$HOME/.fvwm/yad/Icons/time.png":3 \
		--button="!$HOME/.fvwm/yad/Icons/win.png":4 \

foo=$?

if [[ $foo -eq 1 ]]; then
scrot -d 1 'My_FVWM_%a-%d%b%y_%H.%M.png' -e 'viewnior ~/$f' && exit 0

elif [[ $foo -eq 2 ]]; then
scrot 'My_FVWM_%a-%d%b%y_%H.%M.png' --line style=dash,width=3,color="purple" --select -e 'viewnior ~/$f' && exit 0

elif [[ $foo -eq 3 ]]; then
notify-send ScreenShot "10 seconds" && scrot -d 10 'My_FVWM_%a-%d%b%y_%H.%M.png' -e 'viewnior ~/$f' && exit 0

elif [[ $foo -eq 4 ]]; then
scrot -d 2 -b -u 'My_Window_%a-%d%b%y_%H.%M.png' -e 'viewnior ~/$f' && exit 0

fi
}

MPD(){
	pkill yad
	yad --posx=46 --posy=310 --buttons-layout=center \
		--fixed --image=$HOME/.fvwm/yad/Pop_Icons/music.png \
		--button="!$HOME/.fvwm/yad/Icons/music.png":1 \
		--button="!$HOME/.fvwm/yad/Icons/prev.png":2 \
		--button="!$HOME/.fvwm/yad/Icons/play.png":3 \
		--button="!$HOME/.fvwm/yad/Icons/pause.png":4 \
		--button="!$HOME/.fvwm/yad/Icons/next.png":5 \
		--button="!$HOME/.fvwm/yad/Icons/repeat.png":6 \
		--button="!$HOME/.fvwm/yad/Icons/random.png":7 \
		--button="!$HOME/.fvwm/yad/Icons/exit_mpd.png":8


foo=$?

if [[ $foo -eq 1 ]]; then
	mpd

elif [[ $foo -eq 2 ]]; then
	mpc prev

elif [[ $foo -eq 3 ]]; then
	mpc play

elif [[ $foo -eq 4 ]]; then
	mpc pause

elif [[ $foo -eq 5 ]]; then
	mpc next

elif [[ $foo -eq 6 ]]; then
	mpc repeat

elif [[ $foo -eq 7 ]]; then
	mpc random

elif [[ $foo -eq 8 ]]; then 
	pkill mpd 

fi
}

WALL(){

img=(`find ~/Imagens -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | cut -d':' -f1`)
   feh --bg-scale "${img[$RANDOM % ${#img[@]} ]}"

exec $img
return

}

TRANSPARENCE_BAR(){
pkill yad
Value=$(cat ~/.config/tint2/tools.tint2rc | grep "background_color =" | awk '{print $4}')
Color=$(cat ~/.config/tint2/tools.tint2rc | grep "background_color =" | awk '{print $3}')
YAD=$(yad --posx=46 --posy=388 --image=$HOME/.fvwm/yad/Pop_Icons/bar.png \
          --scale --min-value=1 --max-value=99 --value="$Value" --fixed)

	for i in "$YAD"; do
		if [[ $i -ge 1 ]];then
			sed -i "s/background-color:.*/background-color: rgba(18, 18, 18, 0."$i");/g" ~/.fvwm/rofi/Menus/Mini-menu-dark.rasi
			sed -i "s/background-color:.*/background-color: rgba(245, 245, 245, 0."$i");/g" ~/.fvwm/rofi/Menus/Mini-menu-white.rasi
			sed -i "s/background_color = .*/background_color = "$Color" "$i"/g" ~/.config/tint2/tools.tint2rc
			sed -i "s/background_color = .*/background_color = "$Color" "$i"/g" ~/.config/tint2/tint2rc
			pkill tint2
			tint2 -c ~/.config/tint2/tools.tint2rc & tint2
	fi
	done 
}

RUN_APP(){

RUN=$(
	pkill yad
	yad --licon ~/.fvwm/yad/Icons/terminal.png \
		--no-buttons \
		--entry \
		--posx=46 --posy=470 \
		--completion \
		--fixed)

exec $RUN 

}

WEB_SEARCH(){
pkill yad
Search(){

Entry(){
	yad --licon ~/.fvwm/yad/Icons/google.png \
		--no-buttons \
		--entry \
		--posx=46 --posy=510 \
		--completion \
		--fixed
}

go="$(Entry)"

if [ "$go" > "0" ]; then
     chromium http://www.google.co.uk/search?q="$go" 
fi

}

Search
}

POWER(){
pkill yad
SHUTDOWN(){

yad --timeout=10 --timeout-indicator=bottom \
	--width=500 --posx=550 --posy=400 \
	--text="Shutdown in 10 seconds" --text-align=center --auto-close \
    --button="Cancel":1 
foo=$?

if [[ $foo -eq 1 ]]; then
	shutdown -c
else
	shutdown now
fi
}

	yad --center --buttons-layout=center \
		--fixed --image=$HOME/.fvwm/yad/Pop_Icons/power.png \
		--button="!$HOME/.fvwm/yad/Icons/power.png":1 \
		--button="!$HOME/.fvwm/yad/Icons/reboot.png":2 \
		--button="!$HOME/.fvwm/yad/Icons/lock.png":3 \
		--button="!$HOME/.fvwm/yad/Icons/hibernate.png":4 \
		--button="!$HOME/.fvwm/yad/Icons/exit.png":5 \

foo=$?

if [[ $foo -eq 1 ]]; then
	SHUTDOWN

elif [[ $foo -eq 2 ]]; then
	reboot

elif [[ $foo -eq 3 ]]; then
	i3lock

elif [[ $foo -eq 4 ]]; then
	systemctl suspend

elif [[ $foo -eq 5 ]]; then
	pkill -u -9 $USER

fi
}

case "$1" in

Calendar) CALENDAR 	;;
Color ) SET_COLOR 	;;
wall) WALL 	;;
Power) POWER 	;;
Transparence_bar) TRANSPARENCE_BAR 	;;
Radius) BORDERS_RADIUS 	;;
Frame_Transparence) FRAME_TRANSPARENCE 	;;
Icons) SET_ICONS 	;;
Mode) THEME_MODE ;;
Mpd) MPD 	;;
Position) POSITION ;;
Print) PRINT ;;
Search) WEB_SEARCH 	;;
Run ) RUN_APP 	;;

esac
