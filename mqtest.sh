#!/bin/bash

#  recibe 1 parametro
#       $1 nombre del AP (e.g., Tplink o Alix) que vamos a apagar en primera instancia
#
# el comando completo seria por ejemplo: [$./amqtest.sh Tplink]
#     El mismo que apagaria el AP Tplink

# ./mqtest.sh Tplink
#                 $1


#--------------------------------funciones
echo $(date) > pruebaini.txt

#rm -r /tmp/test
mkdir /tmp/amqtest

fileResult="/tmp/amqtest/results.txt"
fileWaiting="/tmp/fichero.txt"
fileVector="/tmp/amqtest/results2.txt"


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


UpAlix() {
        echo "Starting up Alix"
        ssh root@10.0.1.2 "bash updown.sh UP"
}
DownAlix() {
        echo "Shutting down Alix"
        ssh root@10.0.1.2 "bash updown.sh DOWN"
}
UpTplink() {
        echo "Starting up Tplink"
        ssh root@10.0.1.1 "bash updown.sh UP"
}
DownTplink() {
        echo "Shutting down Tplink"
        ssh root@10.0.1.1 "bash updown.sh DOWN"
}


#--------------------------------------variables
COUNT=80
TESTLIFE=20

###------------------------------------void(main)
clear
# Apagamos todo
DownTplink
DownAlix

if [ "$1" = Alix ]; then
	ap1=Alix
	ap2=Tplink
else
	ap1=Tplink
	ap2=Alix
fi

c=1

echo $(date) >> pruebaini.txt

for HEARTBEAT in 580; do
	echo "----------------------------------------------------------------Welcome to new test"
	for SIZE in 512 1024 3072 6144; do		#son tamaños pequenos
	#for SIZE in 10240 51200 102400; do 		#tamaños grandes
	#for SIZE in 102400; do
       	for FRECUENCY in 10 100 500 1000; do
		#for FRECUENCY in 500 1000; do

				if [ $FRECUENCY = "10" ]; then
                        COUNT=500
						wait=1
                else
                       	COUNT=50
						wait=5
				fi


                while [ $c -le 1 ]	#cien pruebas
				do
				echo "=============================================================================="
				echo "="
				echo "=  Configurations: size: $SIZE , frecuency: $FRECUENCY , heartbeat: $HEARTBEAT , test: $c "
				echo "="
				echo "=============================================================================="

			        Down"$ap2"		# 1.apaga2
			        Up"$ap1"		# 2.encender1
			        sleep 5			# 3.esperar 5seg.

				# 4.lanzamos el producer
				#bash /home/jorlu/amqt2.sh $SIZE $FRECUENCY $COUNT $HEARTBEAT &

				#bash /home/jorlu/amqt2.sh $SIZE $FRECUENCY $TESTLIFE $HEARTBEAT &
				bash /home/jorlu/mqtt2.sh $SIZE $FRECUENCY $TESTLIFE $HEARTBEAT &

				echo "---->  AMQPerf in action  <----"

				#sleep 3	        # 5.esperar n-2 seg.
				Up"$ap2"	        # 6.encender2
				sleep $wait	        # 7.esperar 2 seg.
				Down"$ap1"	        # 8.apaga1

				while [ ! -f $fileWaiting ]
	            do
					sleep 10
					echo "--- waiting to the end ---"
				done

				rm $fileWaiting

				echo "End of test "

				# 9. kill java hang
				bash /home/jorlu/killjava.sh
				(( c++ ))
			done
			c=1
		done
	done
done

#cp "/home/jorlu/workspace2/Script Project/resu.sh" /tmp/test
#cp "/home/jorlu/workspace2/Script Project/graficar.sh" /tmp/test
#cp "/home/jorlu/workspace2/Script Project/procesado.sh" /tmp/test

cd /tmp/test/
chmod +x *.sh
#bash /tmp/test/procesado.sh
echo $(date) >> pruebaini.txt
