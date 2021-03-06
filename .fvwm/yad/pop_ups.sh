#!/bin/bash

###############################################################
# Nome: PCFvwm "Popups de controle Fvwm"
# Criado por: Diego Cesare <diegocesare300491@gmail.com>
# Descrição: Um conjunto de ferramentas para manipular e,
# configurar o gerenciador de janelas Fvwm
###############################################################

# Controle do raio das bordas, por padrao o maximo ira de 1 a 12,
# se quiser almentar o raio da borda, altere (--max-value=12), para
# o valor desejado.

BORDERS_RADIUS(){
Value=$(cat ~/.fvwm/picom.conf | grep corner-radius | sed 's/.*= //g;s/;//g')
YAD=$(pkill yad
		yad --text="Border Radius" --scale --posx=50 --posy=37 \
			--width=300 --inc-buttons --min-value=1 --max-value=12 --value="$Value" )
	  	
	for i in "$YAD"; do
		
		if [[ "$i" > "0" ]];then
			sed -i "s/corner-radius.*/corner-radius = $i;/g" ~/.fvwm/picom.conf
		fi
	done 
}

# Calendario simples

CALENDAR(){
	pkill yad
	yad	--calendar --posx=50 --posy=693 \
		--width=400 \
		--no-buttons \
		
}

# Controle da transparencia das bordas das janelas e das barras de titulos

FRAME_TRANSPARENCE(){
Value=$(cat ~/.fvwm/functions/window_decorrc | grep Tint | awk '{print $3}' | sed -n 1p)
YAD=$(pkill yad
	  yad --scale --posx=50 --posy=76 \
		  --text="Frame Transparency" \
		  --width=300 --inc-buttons --min-value=1 --max-value=100 --value="$Value")

	for i in "$YAD"; do
		if [[ $i > 0 ]];then
			sed -i "s/$Value/$i/g" ~/.fvwm/functions/window_decorrc
			xdotool key super+shift+r
		fi
	done
}

# Controle do modo podendo ser usado o tema escuro ou claro

THEME_MODE(){

Alfa=$(cat ~/.config/tint2/tools.tint2rc | grep "background_color =" | awk '{print $4}')
	
pkill yad
yad --posx=50 --posy=115 --text="Mode"\
	--fixed --buttons-layout=center \
	--button="Dark !$HOME/.fvwm/yad/Icons/dark.png":1 \
	--button="Light !$HOME/.fvwm/yad/Icons/light.png":2 \

foo=$?

if [[ $foo -eq 1 ]]; then
yad --timeout=5 --timeout-indicator=bottom \
	--width=500 --center --pulsate --rtl \
   	--text="Applying theme. Please wait" --text-align=center --auto-close \
   	--no-buttons
sleep 1
sed -i 's/131313/FFFFFF/g' ~/.themes/Midnight/gtk-3.0/gtk.css
sed -i 's/F5F5F5/121212/g' ~/.themes/Midnight/gtk-3.0/gtk.css
sed -i 's/141414/ffffff/g' ~/.themes/Midnight/gtk-3.0/gtk.css
sed -i 's/Colorset 2 bg.*/Colorset 2 bg #121212/g' ~/.fvwm/functions/window_decorrc
sed -i 's/Mini-menu-.*/Mini-menu-dark.rasi -show drun/g' ~/.config/tint2/tools.tint2rc
sed -i "s/background_color = .*/background_color = #121212 "$Alfa"/g" ~/.config/tint2/tools.tint2rc
sed -i "s/background_color = .*/background_color = #121212 "$Alfa"/g" ~/.config/tint2/tint2rc
sed -i "s/font_color .*/font_color = #F5F5F5 100/g" ~/.config/tint2/tint2rc
sed -i "s/font_color .*/font_color = #F5F5F5 100/g" ~/.config/tint2/tools.tint2rc
pkill tint2
tint2 & tint2 -c ~/.config/tint2/tools.tint2rc
xdotool key super+shift+r

elif [[ $foo -eq 2 ]]; then
yad --timeout=5 --timeout-indicator=bottom \
	--width=500 --center \
   	--text="Applying theme. Please wait" --text-align=center --auto-close \
   	--no-buttons
sleep 1
sed -i 's/FFFFFF/131313/g' ~/.themes/Midnight/gtk-3.0/gtk.css
sed -i 's/121212/F5F5F5/g' ~/.themes/Midnight/gtk-3.0/gtk.css
sed -i 's/ffffff/141414/g' ~/.themes/Midnight/gtk-3.0/gtk.css
sed -i 's/Colorset 2 bg.*/Colorset 2 bg #F5F5F5/g' ~/.fvwm/functions/window_decorrc
sed -i 's/Mini-menu-.*/Mini-menu-white.rasi -show drun/g' ~/.config/tint2/tools.tint2rc
sed -i "s/background_color = .*/background_color = #F5F5F5 "$Alfa"/g" ~/.config/tint2/tools.tint2rc
sed -i "s/background_color = .*/background_color = #F5F5F5 "$Alfa"/g" ~/.config/tint2/tint2rc
sed -i "s/font_color .*/font_color = #121212 100/g" ~/.config/tint2/tint2rc
sed -i "s/font_color .*/font_color = #121212 100/g" ~/.config/tint2/tools.tint2rc
pkill tint2
tint2 & tint2 -c ~/.config/tint2/tools.tint2rc 
xdotool key super+shift+r
fi

}

# Controle para mudar a posiçao das barras de titulos, podendo se mudas para
# esquerda,topo,direita e abaixo

POSITION(){
	pkill yad
	yad --posx=50 --posy=153 --buttons-layout=center \
		--fixed --text="Title Bar Position" \
		--button="Left !$HOME/.fvwm/yad/Icons/left.png":1 \
		--button="Top !$HOME/.fvwm/yad/Icons/top.png":2 \
		--button="Right !$HOME/.fvwm/yad/Icons/right.png":3 \
		--button="Bottom !$HOME/.fvwm/yad/Icons/bottom.png":4 \

foo=$?

if [[ $foo -eq 1 ]]; then
sed -i 's/TitleAt.*/TitleAtLeft/g' ~/.fvwm/functions/window_decorrc 
xdotool key super+shift+r
elif [[ $foo -eq 2 ]]; then
sed -i 's/TitleAt.*/TitleAtTop/g' ~/.fvwm/functions/window_decorrc 
xdotool key super+shift+r
elif [[ $foo -eq 3 ]]; then
sed -i 's/TitleAt.*/TitleAtRight/g' ~/.fvwm/functions/window_decorrc
xdotool key super+shift+r
elif [[ $foo -eq 4 ]]; then
sed -i 's/TitleAt.*/TitleAtBottom/g' ~/.fvwm/functions/window_decorrc
xdotool key super+shift+r
fi
}

# Ferramenta para alterar as cores da bordas das barras, barras de titulos das jenelas
# e alguns aspectos dos temas GTK como, caixas de dialogos,mesnus etc...

SET_COLOR(){
Value=$(cat ~/.fvwm/functions/window_decorrc | grep Tint | awk '{print $2}' | sed -n 1p)
Color_Dark=$(cat ~/.themes/Midnight/gtk-3.0/gtk.css | grep secondary-caret | awk '{print $2}' | sed 's/;//g')
frame=$(cat ~/.fvwm/functions/window_decorrc | grep Tint | awk '{print $3}' | sed -n 1p)

YAD=$(pkill yad
	yad --color --gtk-palette \
		--posx=50 --posy=200 \
		--fixed
)

OUT=$(echo "$YAD" | sed 's/#//g')

if [[ $OUT == 121212 ]]; then
sed -i "s/Tint .*/Tint "$Value" $frame/g" ~/.fvwm/functions/window_decorrc
elif [[ $OUT == FFFFFF ]]; then
sed -i "s/Tint .*/Tint "$Value" $frame/g" ~/.fvwm/functions/window_decorrc
elif [[ $OUT == F5F5F5 ]]; then
sed -i "s/Tint .*/Tint "$Value" $frame/g" ~/.fvwm/functions/window_decorrc
elif [[ $OUT == 131313 ]]; then
sed -i "s/Tint .*/Tint "$Value" $frame/g" ~/.fvwm/functions/window_decorrc
elif [[ $OUT < 0 ]]; then
sed -i "s/Tint .*/Tint "$Value" $frame/g" ~/.fvwm/functions/window_decorrc
else
sed -i "s/Tint .*/Tint "#$OUT" $frame/g" ~/.fvwm/functions/window_decorrc
sed -i "s/$Color_Dark/"#$OUT"/g" ~/.themes/Midnight/gtk-3.0/gtk.css
xdotool key super+shift+r
fi
}

# Ferramenta para alterar os icones das barras de titulos

SET_ICONS(){
	pkill yad	
	yad --posx=50 --posy=232 --text="Window Icons" \
		--fixed --buttons-layout=center \
		--button="Blocks":1 \
		--button="Cicles":2 \
		--button="W10":3 \
		--button="MacOS":4 \
		--button="Classic":5 \
		--button="Simple":6 \
		--button="Fit":7 \
		--button="Fit Modern":8 \

foo=$?

if [[ $foo -eq 1 ]]; then
sed -i 's/icons\/.*/icons\/blocks/g' ~/.fvwm/config 
xdotool key super+shift+r
elif [[ $foo -eq 2 ]]; then
sed -i 's/icons\/.*/icons\/circles/g' ~/.fvwm/config 
xdotool key super+shift+r
elif [[ $foo -eq 3 ]]; then
sed -i 's/icons\/.*/icons\/w10/g' ~/.fvwm/config 
xdotool key super+shift+r
elif [[ $foo -eq 4 ]]; then
sed -i 's/icons\/.*/icons\/macos/g' ~/.fvwm/config 
xdotool key super+shift+r
elif [[ $foo -eq 5 ]]; then
sed -i 's/icons\/.*/icons\/classic/g' ~/.fvwm/config
xdotool key super+shift+r
elif [[ $foo -eq 6 ]]; then
sed -i 's/icons\/.*/icons\/wcircles/g' ~/.fvwm/config	
xdotool key super+shift+r
elif [[ $foo -eq 7 ]]; then
sed -i 's/icons\/.*/icons\/fit/g' ~/.fvwm/config	
xdotool key super+shift+r
elif [[ $foo -eq 8 ]]; then
sed -i 's/icons\/.*/icons\/modern/g' ~/.fvwm/config	
xdotool key super+shift+r
fi

}

# Conjunto de ferramentas para obter capturas de tela

PRINT(){
	pkill yad
	yad --posx=50 --posy=270 --buttons-layout=center \
		--fixed  --text="ScreenShot" \
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

# Ferramemta para controle de musicas

MPD(){
	pkill yad
	yad --posx=50 --posy=310 --buttons-layout=center \
		--fixed --text="Music Control" \
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

# Ferramenta para alterar os plano de fundo de forma aleatoria

WALL(){

img=(`find ~/Imagens -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | cut -d':' -f1`)
   feh --bg-scale "${img[$RANDOM % ${#img[@]} ]}"

}

# Ferramenta para alterar a transparencia da barra

TRANSPARENCE_BAR(){
pkill yad
Value=$(cat ~/.config/tint2/tools.tint2rc | grep "background_color =" | awk '{print $4}')
Color=$(cat ~/.config/tint2/tools.tint2rc | grep "background_color =" | awk '{print $3}')
YAD=$(yad --posx=50 --posy=388 --text="Transparency Bar" \
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

# Ferramenta para execuar aplicaçoes

RUN_APP(){

RUN=$(
	pkill yad
	yad --licon ~/.fvwm/yad/Icons/terminal.png \
		--no-buttons \
		--entry \
		--center \
		--completion \
		--fixed)

exec $RUN 

}

# Ferramenta para pesquisar na web.
# Por padrao o motor de busca é o chromium, podendo ser alterado para qualquer outro,
# mudando "chromium" na linha "chromium http://www.google.co.uk/search?q="$go""
# para o seu navegador.

WEB_SEARCH(){
pkill yad
Search(){

Entry(){
	yad --licon ~/.fvwm/yad/Icons/google.png \
		--no-buttons \
		--entry \
		--center \
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

# Ferramenta para gerenciar as sessoes

POWER(){
pkill yad

SHUTDOWN(){

yad --timeout=10 --timeout-indicator=bottom \
	--width=500 --center \
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
		--fixed --text="Power Menu" \
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
