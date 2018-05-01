#!/bin/bash

# 2018/04/21 Marnik : first commit

# Execute this command on the command line to get usage discription :
#	bash ventctl.sh

ARGS=1         # Script requires 1 argument.
E_BADARGS=85   # Wrong number of arguments passed to script.
E_UNKNOWN=86   # Unknown option.

PIPE="vent_pipe"
MAXATTEMPT=3

# Function vent_read() is a daemon function
# It is called with : 
#	vent_read &
#	sleep 1
#	disown
# The "&" makes it run in the background.
# It will get it's own process ID but the name will still be the name of this script!
# Commands to this daemon are passed via the pipe $PIPE
# The "sleep 1" is needed to establish the pipe correctly.
# If the sleep command is ommited, the pipe will be a regular file instead!!!
# The "disown" will make this function stay alive when this shell script terminates
# When the daemon terminates it will close the pipe (trap on EXIT).
# The proper way to terminate the daemon is by executing the command :
#	bash ventctl.sh stop
vent_read() {

	trap "rm -f $PIPE" EXIT

	mkfifo $PIPE

	read msg <$PIPE # wait for first message

	while :; do # infinite loop
		if [[ "$msg" == 'stop' ]]; then
			exit 0
		fi
		ebusctl w -c kwl FanSpeed $msg
		# https://stackoverflow.com/questions/6448632/read-not-timing-out-when-reading-from-pipe-in-bash
		if read -t 60 <>$PIPE ; then
			msg="$REPLY"
		fi
	done

}

if [ $# -eq "$ARGS" ]; then # check the number of arguments
	case $1 in
		"Minimal"|"Reduced"|"Normal"|"Intensive")
		SPEEDMODE=$1
		exitcode=1
		;;
		"stop")
		exitcode=0
		;;
		*)
		exitcode=$E_UNKNOWN
		;;
	esac
else
	exitcode=$E_BADARGS
fi

if [ "$exitcode" -gt 1 ]; then
	echo "Usage: bash "$(basename $0)" Minimal|Reduced|Normal|Intensive|stop"
	exit $exitcode
fi

if [ "$exitcode" -eq 0 ]; then
	if [[ ! -p $PIPE ]]; then
		echo "pipe not open - unable to send stop message"
		exit 1
	fi
	echo "stop" >$PIPE
	exit 0
fi

if [[ ! -p $PIPE ]]; then
	vent_read &
	sleep 1
	disown
fi

echo "$SPEEDMODE" >$PIPE
