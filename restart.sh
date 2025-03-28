#!/bin/bash

count=0
time=$(date +%s)
while [ true ]; do

	java -Xms4096M -Xmx4096M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -jar server.jar --nogui
    if [ $(($(date +%s) -  $time)) -lt 300 ]
    then
		echo "below 300"
		((count++))
		echo $count
		if [[ $count = 3 ]]
		then
        	echo exiting
			exit 1
		fi
    else
        count=0
		echo "above 300"
        time=$(date +%s)
	fi
        echo Server restarting...

        echo Press CTRL + C to stop.
        sleep 10
done	
