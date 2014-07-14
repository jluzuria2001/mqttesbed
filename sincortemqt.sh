#!/bin/bash

# ./sincorte.sh

#--------------------------------funciones
export TERM=${TERM:-dumb}

echo $(date) > pruebaini.txt

#rm -r /tmp/test
mkdir /tmp/test

fileResult="/tmp/test/results.txt"
fileWaiting="/tmp/fichero.txt"
fileVector="/tmp/test/results2.txt"
fileReg="/tmp/test/pruebaini.txt"


if [ -e $fileResult ]; then
	rm $fileResult
else
	echo "-"
fi

if [ -e $fileWaiting ]; then
	rm $fileWaiting
else
	echo "--"
fi

if [ -e $fileVector ]; then
  	rm $fileVector
else
	echo "---"
fi

#--------------------------------------variables
COUNT=80
TESTLIFE=240 	#240 segundos

###------------------------------------void(main)
clear

c=1

echo "ini: " $(date) >> $fileReg
bash /home/jorlu/rate.sh &

for HEARTBEAT in 580; do
	echo "----------------------------------------------------------------Welcome to new test"
  #tamaños grandes
	for SIZE in 51200 61440 71680 81920 92160; do
	#for SIZE in 154000; do

  	for FRECUENCY in 20 25 33 50; do
    #for FRECUENCY in 33; do

			if [ $FRECUENCY = "10" ]; then
	                        COUNT=500
				wait=1
        	        else
                         	COUNT=50
				wait=5
			fi

#				while [ $c -le 100 ]		#Una prueba
				while [ $c -le 1 ]
				do
#				restart
				echo "=============================================================================="
				echo "="
				echo "=  Configurations: size: $SIZE , frecuency: $FRECUENCY , heartbeat: $HEARTBEAT , test: $c "
				echo "="
				echo "=============================================================================="


				# 4.lanzamos el producer
				#bash /home/jorlu/amqt2.sh $SIZE $FRECUENCY $COUNT $HEARTBEAT &
				#bash /home/jorlu/amqt2.sh $SIZE $FRECUENCY $TESTLIFE $HEARTBEAT &
				bash /home/jorlu/mqtt2.sh $SIZE $FRECUENCY $TESTLIFE $HEARTBEAT &

				echo "---->  AMQPerf in action  <----"

				while [ ! -f $fileWaiting ]
				do
					sleep 10
					echo "--- waiting to the end ---"
				done

				rm $fileWaiting
#				restart

				echo "End of test "

				# 9. kill java hang
				bash /home/jorlu/killjava.sh
				(( c++ ))
			done
			c=1
		done
	done
done

echo "fin: " $(date) >> $fileReg

tempVar=$(ps axu | grep "/home/jorlu/rate.sh" | awk '{print $2}' | head -1)
echo "killing " $tempVar
kill -9 $tempVar
