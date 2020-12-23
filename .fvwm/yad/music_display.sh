#!/bin/bash

while true; do

PERC=$(mpc | sed -n 2p | awk '{print $4}' | sed 's/[()%]//g')
MUSIC=$(mpc current)

echo "$PERC"

done | yad  --colunm=$MUSIC 