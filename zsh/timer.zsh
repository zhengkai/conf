# via https://github.com/popstas/zsh-command-time

_command_time_preexec() {
	timer=${timer:-$SECONDS}
	export ZSH_COMMAND_TIME=""
}

_command_time_precmd() {
	if [ $timer ]; then
		timer_show=$(($SECONDS - $timer))
		if [ -n "$TTY" ] && [ $timer_show -ge 5 ]; then
			export ZSH_COMMAND_TIME="$timer_show"
			zsh_command_time
		fi
		unset timer
	fi
}

zsh_command_time() {
	if [ -n "$ZSH_COMMAND_TIME" ]; then

		local hour=$(($ZSH_COMMAND_TIME/3600))
        local min=$(($ZSH_COMMAND_TIME/60%60))
        local sec=$(($ZSH_COMMAND_TIME%60))

		if [ "$hour" -ge 1 ]; then

			timer_show=$(printf '%dh:%02dm:%02ds\n' $hour $min $sec)

        elif [ "$min" -ge 1 ]; then

			timer_show=$(printf '%dm:%02ds\n' $min $sec)

		else

			timer_show=$(printf '%ds\n' $sec)

		fi

		print -P '%F{105}`printf "\nTime: %s\n" "$timer_show"`%f'
	fi
}

precmd_functions+=(_command_time_precmd)
preexec_functions+=(_command_time_preexec)
