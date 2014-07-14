#!/bin/bash

## To control if any message was lost in the test
## It's print on terminal when only has a lost message 
## the id of the test that has this problem.


#path="/home/jorg/Desktop/weekend/mqtt/test"
path="/home/jorlu/Escritorio/mqtt/test"

for siz in 512 1024 3072 6144; do
	for per in 10 100 500 1000; do 

#for siz in 512; do
#	for per in 10; do
		size="/"$siz"/"
		folderPeriod=$path$size$per						# /home/jorlu/Escritorio/mqtt/test/512/10

			
		for (( count=1; count<=100; count++ )) do
		#for (( count=1; count<=1; count++ )) do
		 
			fileName="s"$siz"T"$per".out"$count		# filename = s512T10.out1
			file=$folderPeriod"/"$fileName
		
			if [ -e $file ]; then
					
					a=$(wc -l $file | awk '{print$1}' $fileOutput)
					b=$(tail -1 $file | awk '{print$1}' $fileOutput)
					
					if [ $a != $b ]; then
						echo "-----------------------------------------------"
						echo "SIZE: " $siz " PERIOD: " $per " TEST: " $count
						
						echo $a $b
					else
						echo ""
					fi

			else
					echo -e "\n $file file not found"
			fi
	
		done
		#for count
	done 
	#for per
done 
#for siz
