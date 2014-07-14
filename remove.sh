#!/bin/bash

path="/home/jorg/Desktop/weekend/mqtt/test/"
final="/max/"

for siz in 512 1024 3072 6144; do
	cd $path$siz$final
	rm *.png
	rm *.sta
done
