#!/bin/bash

## get the number of thread throw in each test

#for siz in 51200 61440 71680 81920 92160; do
#for siz in 92160 102400 112640 122880 133120 143360; do
for siz in 225280 235520 245760 286720; do
#for siz in 296960; do
#for siz in 153600 179200 194600 204800 215040 230400 256000 307200; do 

	path="/home/jorlu/Escritorio/saturacionmqtt/test/"$siz"/rates/"
	
	cd $path
	
	for x in `ls *.txt`; do 
		#echo $x
		
		a=$(less $x | grep Size | awk '{print$6}')
		b=$(less $x | grep Frecuency | awk '{print$5}')
		c=$(less $x | grep thread | tail -1 | awk '{print$3}')
		
		#echo "S: " $a " T: " $b " threads: " $c			
		echo $a $b $c
	done

done
