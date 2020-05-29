#!/bin/bash

per=$( /usr/bin/upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage| /usr/bin/awk '{split($0,a,"percentage:"); print a[2]}'| /usr/bin/awk '{split($0,a,"%"); print a[3] a[2] a[1]}' | xargs )
state=$( /usr/bin/upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep state:|/usr/bin/awk '{split($0,a,"state:"); print a[2]}'|xargs )


if [ "$per" -lt 31 ] && [ "$state" = "discharging" ]
then
  /usr/bin/notify-send -i /usr/share/icons/gnome/32x32/status/battery-caution.png 'Conectar a Corriente' "Bateria al $per%"
#elif [ "$per" -eq 100 ] && [ "$state" = "fully-charged"  ]
elif [ "$per" -eq 99 ] && [ "$state" = "charging"  ]
then
  /usr/bin/notify-send -i /usr/share/icons/gnome/32x32/status/battery-full-charged.png 'Desconectar de Corriente' "Bateria al $per%"
fi

