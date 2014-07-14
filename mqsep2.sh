#!/bin/bash

##  11july14
##  Separa el fichero producido por la prueba de MQTT
##  en ficheros mas pequeños


#-----------------------------------------------FILE
#path="/home/jorlu/Escritorio/mqtt/test"
path="/home/jorg/Desktop/weekend/mqtt/test"

for siz in 512 1024 3072 6144; do
	for per in 10 100 500 1000; do 

#for siz in 512; do
#	for per in 1000; do
		size="/"$siz"/"
		folderPeriod=$path$size$per						# /home/jorlu/Escritorio/mqtt/test/512/10

			
		for (( count=1; count<=100; count++ )) do
		#for (( count=1; count<=1; count++ )) do
		 
			fileName="s"$siz"T"$per".out"$count		# filename = s512T10.out1
			file=$folderPeriod"/"$fileName
		
			fileOutputSustract=$file".sus"
			fileOutputSustractRes=$file".res"
			if [ -e $file ]; then
					echo "-----------------------------------------------"
					echo "SIZE: " $siz " PERIOD: " $per " TEST: " $count
					head -5 $file
			
					#-----------------------------------------------RESTAMOS FILAS CONTINUAS
					awk 'p{print $3-p}{p=$3}' $file > $fileOutputSustract

					#-----------------------------------------------quitamos la periodicidad
					#awk '$1-=$periodicidad' $fileOutputHigh  #no funciona este comando

					if [ "$per" = "10" ]; then
						awk '{$1-=10}1' $fileOutputSustract > $fileOutputSustractRes
					fi
			
					if [ "$per" = "100" ]; then
						awk '{$1-=100}1' $fileOutputSustract > $fileOutputSustractRes
					fi
			
					if [ "$per" = "500" ]; then
						awk '{$1-=500}1' $fileOutputSustract > $fileOutputSustractRes
					fi
			
					if [ "$per" = "1000" ]; then
						awk '{$1-=1000}1' $fileOutputSustract > $fileOutputSustractRes
					fi
					#------------------------------------------------end_restas
		
					#------------------------------------------------get the maximum
					echo "Getting the max"
					#------------------------------------------------end_maximum
											
			else
					echo -e "\n $file file not found"
			fi
	
		done
		#for count
	done 
	#for per
done 
#for siz
