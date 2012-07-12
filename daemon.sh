#!/usr/bin/bash

pwd

case "$1" in 
    start)
	echo "Initializing server ..."
	ruby server.rb >> .log &
	PID=$!
	echo $PID > ./.pid
	echo "Server running."
	;;
    stop)
        kill `cat .pid`
	echo "" > .pid
	echo "Server Stopped"
	;;
    restart)
        echo "Restarting Server..."
	kill `cat .pid`
	ruby server.rb >> .log &
	PID=$!
	echo $PID > ./.pid
	echo "Done"
	;;
    *)
	echo "usage: $0 {start|stop|restart}"
esac

exit 0

