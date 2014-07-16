#!/bin/bash

## get the number of thread throw in each test

#for siz in 51200 61440 71680 81920 92160; do
#for siz in 92160 102400 112640 122880 133120 143360; do
#for siz in 153600 179200 194600 204800 215040 230400 256000 307200; do
for siz in 225280 235520 245760 286720; do
#for siz in 296960; do 
	for per in 20 25 33 50; do
	
		path="/home/jorlu/Escritorio/saturacionmqtt/test/"$siz"/"
		fileName="s"$siz"T"$per".txt"
	
		if [ -e $file ]; then
			a=$(wc -l $path$fileName | awk '{print$1}')
			echo $siz $per $a
		else
			echo -e "\n $file file not found"
		fi
	done
done
