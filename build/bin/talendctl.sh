#!/bin/bash

BINPATH="/Talend/Runtime_ESBSE/container/bin/"
TIMEOUT=900

help() {
	echo "Usage: $0 [start|stop|bash|service] "
}

#Define cleanup procedure
cleanup() {
    echo -c "Container stopped. "
    stop
}

stop() {
    echo -n "Shutting down Talend ESB" 
    cd $BINPATH
    ./stop
    t=0;
    while [ $(jps | wc -l) -gt 1 ] && [ $t -lt $TIMEOUT ]
    do
	  echo -n .
	  sleep 1 
	  let t=t+1
    done
    echo
    if [ $t -eq $TIMEOUT ]; then
	    >&2 echo "Shutdown aborted: timeout"
	    exit 1
    fi
}

start() {

   echo 
   echo "Ejecutando scripts de pre-arranque..."
   echo  
   for file in $(find /deploy -name "prestart*.sh" | sort) ; do
     echo $file
     bash $file
   done

   echo  
   echo "Starting Talend ESB..." 
   echo  
   cd $BINPATH
   ./start &
   t=0;
   while ! curl --fail -s -o /dev/null http://localhost:8040/services && [ $t -lt $TIMEOUT ]
   do
	  sleep 1 
	  let t=t+1
	  let mod=t%30
      if [ $mod -eq 0 ]; then
      	echo "$t sec ..."
      fi
   done
   if [ $t -eq $TIMEOUT ]; then
      >&2 echo "Talend ESB timeout"
      exit 1
   fi
   echo "Talend ESB started in $t seconds."

   echo 
   echo "Ejecutando scripts de posrt-arranque..."
   echo  
   for file in $(find /deploy -name "poststart*.sh" | sort) ; do
     echo $file
     bash $file &
   done
}

#Trap SIGTERM
trap 'cleanup' SIGTERM


case "$1" in
   start)
      start
      ;;
   stop)
      stop
      ;;
   console)
      start
      ./client
      stop
      ;;
   bash)
      start
      bash
      stop
      ;;
   service)
      start
      while true
      do
      	xtail '/Talend/Runtime_ESBSE/container/log'
      done
      ;;
   *)
      help
      ;;
esac
