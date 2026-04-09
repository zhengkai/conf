#!/bin/bash

# 禁止所有usb 设备（其实只是为了禁键盘，但始终无法精确定位）

if [ "${HOSTNAME,,}" != "surface" ]; then
	echo "run in surface only"
	exit 1
fi

USB_PATH=""

# 远程控制禁止还是允许
SYS="$1"
if [ "$SYS" != "bind" ] && [ "$SYS" != "unbind" ]; then
	CMD="$(curl --noproxy '192.168.50.207' -s --max-time 5 'http://192.168.50.207/surface/keyboard.txt')"
	echo "check tanya"
	if [ "$CMD" == "stop" ]; then
		SYS="unbind"
	else
		SYS="bind"
	fi
fi
echo "$SYS"
SYS="/sys/bus/usb/drivers/usb/${SYS}"

for dev in /sys/bus/usb/devices/*; do
    if [ -f "$dev/idVendor" ]; then
        #vendor=$(cat "${dev}/idVendor")
        #product=$(cat "${dev}/idProduct")

		#echo "$vendor $product $dev"
        #if [ "$vendor" = "045e" ] && [ "$product" = "0922" ]; then
		#	echo 1
        #fi
		USB_PATH="$(basename "$dev")"
		echo "$USB_PATH" | sudo tee "$SYS" || :
    fi
done
