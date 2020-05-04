#!/bin/bash -x

if [ "$1" == "week" ]; then
	WEEK_DAY=$(date '+%u')
	if [ "$WEEK_DAY" != '3' ]; then
		echo 'no'
		exit
	fi
fi

################################################################################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
################################################################################
#
# Script updates can be found at: https://github.com/extremeshok/geoip-update.sh
#
# License: BSD (Berkeley Software Distribution)
#
################################################################################
#
# Unlike other maxmind database update scripts, this will only download the
# databases when they have been updated. The databases are extracted directly
# to the geoip dir and as such this script does not use a temp dir and a copy
# The script will also create symbolic links to alias the various database
# names to legacy database names.
#
################################################################################
#
#    THERE ARE  USER CONFIGURABLE OPTIONS IN THIS SCRIPT
#   ALL CONFIGURATION OPTIONS ARE LOCATED BELOW THIS MESSAGE
#
################################################################################

#### User Config ################################

# Enable to prevent issues with multiple instances running
# To disable, set the following variable to "no".
enable_locking="yes"

# program directories
work_dir="/var/lib/GeoIP"
geoip_dir="/usr/share/GeoIP"

#database urls
geo_db_urls="
http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.mmdb.gz
http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
http://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz
http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
http://geolite.maxmind.com/download/geoip/database/GeoLiteCityv6-beta/GeoLiteCityv6.dat.gz
http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz
http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNumv6.dat.gz
" #this is important

#filename #link
geo_symbolic_db_filname_link="
GeoIP.dat|GeoLiteCountry.dat
GeoIPv6.dat|GeoLiteCountryv6.dat
GeoLiteCity.dat|GeoIPCity.dat
GeoLiteCityv6.dat|GeoIPCityv6.dat
GeoIPASNum.dat|GeoLiteASNum.dat
GeoIPASNumv6.dat|GeoLiteASNumv6.dat
" #this is important

#### End of User Config #########################

################################################################################

######  #######    #     # ####### #######    ####### ######  ### #######
#     # #     #    ##    # #     #    #       #       #     #  #     #
#     # #     #    # #   # #     #    #       #       #     #  #     #
#     # #     #    #  #  # #     #    #       #####   #     #  #     #
#     # #     #    #   # # #     #    #       #       #     #  #     #
#     # #     #    #    ## #     #    #       #       #     #  #     #
######  #######    #     # #######    #       ####### ######  ###    #

################################################################################

if [[ $EUID -ne 0 ]]; then
	sudo "$0"
	exit $?
fi

# Detect to make sure the entire script is avilable, fail if the script is missing contents
if [ ! "$( tail -1 "$0" | head -1 | cut -c1-7 )" == "exit \$?" ] ; then
	echo "FATAL ERROR: Script is incomplete, please redownload"
	exit 1
fi

################ Functions

# Function to create a pid file
function xshok_create_pid_file { #pid.file
	if [ "$1" ] ; then
		pidfile="$1"
		echo $$ > "$pidfile"
		if [ $? -ne 0 ] ;  then
			echo "ERROR: Could not create PID file: $pidfile"
			exit 1
		fi
	else
		echo "ERROR: Missing value for option"
		exit 1
	fi
}

################ Main Program

# Set dir permissions
mkdir -p "$work_dir"
mkdir -p "$geoip_dir"

# Enable pid file to prevent issues with multiple instances
# opted not to use flock as it appears to have issues with some systems
if [ "$enable_locking" == "yes" ] ; then
	pid_file_fullpath="/tmp/geoip-update.pid"
	if [ -f $pid_file_fullpath ] ; then
		pid_file_pid=$(cat $pid_file_fullpath)
		ps -p "$pid_file_pid" > /dev/null 2>&1
		if [ $? -eq 0 ] ; then
			echo "ERROR: Only one instance can run at the same time."
			exit 1
		else
			xshok_create_pid_file "$pid_file_fullpath"
		fi
	else
		xshok_create_pid_file "$pid_file_fullpath"
	fi
	# run this wehen the script exits
	trap -- "rm -f $pid_file_fullpath" EXIT
fi

if [ -n "$geo_db_urls" ] ; then
	for geo_url in $geo_db_urls ; do

		geo_url_filename="${geo_url##*/}"
		geo_filename="${geo_url_filename%.gz*}"

		if [[ "$(curl --compressed --retry 3 --retry-delay 3 "$geo_url" --time-cond  "$work_dir/$geo_url_filename" --output "$work_dir/$geo_url_filename" --silent --fail --location --write-out %{http_code} 2> /dev/null)" == "200" ]]; then

			if [ -f "$work_dir/$geo_url_filename" ]; then
				zcat --decompress --force --quiet  "$work_dir/$geo_url_filename" --stdout > "$geoip_dir/$geo_filename"
				if [ "$0" ]; then
					echo "Updated $geo_filename"
				fi
			fi
		fi
	done
fi

if [ -n "$geo_symbolic_db_filname_link" ] ; then
	for geo_symbolic_filname_link in $geo_symbolic_db_filname_link ; do
		if [[ "$geo_symbolic_filname_link" =~ "|" ]] ; then
			geo_symbolic_link=$(echo "$geo_symbolic_filname_link" | cut -d "|" -f2)
			geo_symbolic_filname=$(echo "$geo_symbolic_filname_link" | cut -d "|" -f1)
			if [ ! -e "$geoip_dir/$geo_symbolic_link" ] && [ -f "$geoip_dir/$geo_symbolic_filname" ] ; then
				ln -s "$geoip_dir/$geo_symbolic_filname" "$geoip_dir/$geo_symbolic_link"
				if [ "$0" ]; then
					echo "Created symbolic link $geo_symbolic_filname ------ $geo_symbolic_link"
				fi
			fi
		fi
	done
fi

# And lastly we exit, Note: the exit is always on the 2nd last line
exit $?
