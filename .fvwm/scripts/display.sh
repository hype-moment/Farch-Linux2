#!/bin/bash

MUSIC_DISPLAY(){

Repeat(){

REPEAT(){
rep=$(mpc | grep repeat | awk '{print $4}')
	
	if [[ $rep = on ]]; then
		echo ""
	fi
}

STATUS=$(mpc | sed -n 2p | awk '{print $1}' | sed 's/\[//g;s/]//g')

if [[ $STATUS = playing ]]; then
	echo "$(REPEAT)"
fi

}

Random(){

RANDOM(){
ran=$(mpc | grep repeat | awk '{print $6}')
	
	if [[ $ran = on ]]; then
		echo ""
	fi
}

STATUS=$(mpc | sed -n 2p | awk '{print $1}' | sed 's/\[//g;s/]//g')

if [[ $STATUS = playing ]]; then
	echo "$(RANDOM)"
fi

}

Artist(){
	ARTIST(){
		mpc | sed -n 1p | awk '{print $1" "$2}'
	}
STATUS=$(mpc | sed -n 2p | awk '{print $1}' | sed 's/\[//g;s/]//g')

if [[ $STATUS = playing ]]; then
	echo "|  $(ARTIST)"
fi

}

Music(){
	MUSIC(){
		mpc | sed -n 1p | sed 's/.* - //g;s/.mp3//g'
	}
STATUS=$(mpc | sed -n 2p | awk '{print $1}' | sed 's/\[//g;s/]//g')

if [[ $STATUS = playing ]]; then
	echo " $(MUSIC) |"
fi

}

echo "$(Artist) $(Music) $(Repeat) $(Random)"

}

MEMORY(){
	Mem=$(free -h | grep Mem | awk '{print $3}')
		echo " $Mem"
}

CPU(){

  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ));

     echo " $cpu%"
}

DISTRO(){
	Dist=$(cat /etc/os-release | grep NAME | sed 's/.*="//g;s/"//g' | sed -n 1p)
		echo " $Dist"
}

KERNEL(){
	Ker=$(uname -r)
		echo " $Ker"
}

DISK(){
	Root=$(df -h | grep '/dev/sda1' | awk '{print $5}')
	Home=$(df -h | grep '/dev/sdb1' | awk '{print $5}')

		echo " $Root  $Home"	
}

case $1 in 
	repeat) Repeat 	;;
	random) Random 	;;
	artist) Artist 	;; 
	music) MUSIC_DISPLAY 	;;
	memory) MEMORY 	;;
	cpu) CPU 	;;
	distro) DISTRO 	;;
	kernel) KERNEL 	;;
	disk)	DISK 	;;
esac