#!/bin/sh
### BEGIN INIT INFO
# Provides:          linshare_deployment
# Required-Start:    
# Required-Stop:
# Default-Start:   2 3 4 5  
# Default-Stop:    0 1 6
# X-Start-Before:    
# Short-Description: bootclean after checkroot.
# Description:       Start apache2 and execute java command on the jar file
### END INIT INFO

# declaration of java home variable, here you can give the path to your java environment
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/

# Declaration of the file where you will keep the pid of your process
PIDFILE=/var/run/linshare_uploadproposition.pid

case "$1" in
start)
	echo "executing ..."

	#Execution of the java process
	${JAVA_HOME}/bin/java -jar /usr/local/sbin/linshare-uploadproposition.jar server /etc/linshare/linshare-uploadproposition-production.yml &

	PID=$!
	if [ -z ${PID} ]; then
	    echo "fail..."
	else
	    echo ${PID} > ${PIDFILE}
	    echo "OK!!!!"
	fi
	;;
stop)
	echo "Stopping..."
       	PID=`cat ${PIDFILE}`
	if [ -f ${PIDFILE} ]; then
	    kill -HUP ${PID}
	    echo "Done"
	    rm -f ${PIDFILE}
	else
	    echo "pidfile not found"
	fi
	;;
status)
	echo "Checking..."

	#first check to see is there is any pidfile
	if [ -f ${PIDFILE} ]; then
	    PID=`cat ${PIDFILE}`

	    #Checking if the pid kept in the pidfile is not in the list of the processes
	    if [ -z "`ps aux | grep ${PID} | grep -v grep`" ]; then
		echo "Process dead but pid exists"
	    else
		echo "Process is running"
	    fi
	else 
	     echo "Service is not running"
	fi
	;;
esac
