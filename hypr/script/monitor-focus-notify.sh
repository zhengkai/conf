#! /usr/bin/env bash

last_monitor=""

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    if [[ "$line" == focusedmon\>\>* ]]; then
        # 格式: focusedmon>>MONITOR_NAME,WORKSPACE_ID
        monitor_name="${line#focusedmon>>}"
        monitor_name="${monitor_name%%,*}"

		if [[ "$last_monitor" != "" && "$last_monitor" != "$monitor_name" ]]; then

			# 切换了显示器，发送通知
			notify-send -t 800 -u normal "󰍹 Monitor" "$monitor_name" \
				-h string:x-canonical-private-synchronous:monitor-switch \
				-h string:x-mako-output:"$monitor_name"
		fi

		last_monitor="$monitor_name"
	fi
done
