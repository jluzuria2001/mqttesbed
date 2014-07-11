#!/bin/bash

##  11july14
##  Separa el fichero producido por la prueba de MQTT
##  en ficheros mas pequeños


#-----------------------------------------------FILE
path="/home/jorlu/Escritorio/mqtt/test"


#for siz in 512 1024 3072 6144; do
#	for per in 10 100 500 1000; do 

for siz in 512; do
	for per in 1000; do

			fileName="s"$siz"T"$per".txt"		# s512T10.txt
	
			size="/"$siz"/"
			file=$path$size$fileName	    	# /home/jorlu/Escritorio/mqtt/test/512/s512T10.txt
	
			if [ -e $file ]; then
				echo "-----------------------------------------------"
				echo "SIZE: " $siz " PERIOD: " $per
				head -5 $file
		
				folderPeriod=$path$size$per						# /home/jorlu/Escritorio/mqtt/test/512/10

				if [ -e $folderPeriod ]; then
					echo "folder --> $folderPeriod <-- already exist"
				else
					mkdir $folderPeriod
					fileNameOutSubstract="s"$siz"T"$per".out"		# s512T10.out
					fileOutputSustract=$folderPeriod"/"$fileNameOutSubstract
			
#separamos el fichero grande en pequenos
while read line;
		do
		tempVar=$(echo $line | awk '{print $1}')
		
		if [ $tempVar -eq "1" ]; then
			((count++))
			echo -e "Found new test $count \n ... please wait ..." 
			newfile=$fileOutputSustract$count				# s512T10.out98
			echo $line > $newfile
			
		else
			echo $line >> $newfile 
		fi
done < $file
#end_separation-------------------------------------			
				fi			
	
			else
				echo -e "\n $fileName file not found"
			fi
	

	done 
	#for per	
done 
#for siz
