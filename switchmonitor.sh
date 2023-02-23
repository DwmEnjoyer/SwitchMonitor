#!/bin/sh

ctrl_c() {
	gum style --foreground 212 --align left 'Exiting...'
	exit 2
}

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Welcome to SwitchMonitor' 'Change output between monitors'

gum style --foreground 212 --align left 'Primary monitor:'
interno=$(xrandr | grep -w "connected" | awk '{ print $1 }' | gum choose --limit 1)
if [ -z $interno ]
then
      ctrl_c
fi
echo $interno
gum style --foreground 212 --align left 'Secondary monitor:'
externo=$(xrandr | grep -w "connected" | awk '{ print $1 }' | gum choose --limit 1)
if [ -z $externo ]
then
      ctrl_c
fi
echo $externo
gum style --foreground 212 --align left 'Desired resolution:'
resolucion=$(gum input --placeholder "Resolution...")
if [ -z $resolucion ]
then
      ctrl_c
fi
echo $resolucion
gum style --foreground 212 --align left 'Choose monitor:'
opcion=$(gum choose --limit 1 Main Secondary Both)
if [ -z $opcion ]
then
      ctrl_c
fi

if [ $opcion == "Main" ]
then
	if [ $resolucion == "auto" ]
	then
		xrandr --output $externo --off --output $interno --auto
	else
		xrandr --output $externo --off --output $interno --mode $resolucion
	fi
elif [ $opcion == "Secondary" ]
then
	if [ $resolucion == "auto" ]
        then
	       	xrandr --output $interno --off --output $externo --auto
	else
	       	xrandr --output $interno --off --output $externo --mode $resolucion
	fi
elif [ $opcion == "Both" ]
then
	if [ $resolucion == "auto" ]
        then
	       	xrandr --output $externo --auto --same-as $interno --auto
	else
	       	xrandr --output $externo --mode $resolucion --same-as $interno --mode $resolucion
	fi
else
	echo "La opcion introducida no es valida."
	exit 1
fi
