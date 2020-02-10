#!/bin/bash

#Device name variable
devicename="alsa_output.usb-Logitech_BCC950_ConferenceCam_6E3D9609-00.iec958-stereo"

#change the default sink
pacmd "set-default-sink "$devicename""

#move all inputs to the new sink
for app in $(pacmd list-sink-inputs | sed -n -e 's/index:[[:space:]]\([[:digit:]]\)/\1/p');
do
	pacmd "move-sink-input $app "$devicename""
done
