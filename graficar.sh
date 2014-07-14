#!/bin/bash
#script para graficar los ficheros de resultados que hemos tratado previamente

path="/home/jorg/Desktop/weekend/mqtt/test"

for siz in 512 1024 3072 6144; do
#for siz in 512; do
	for per in 10 100 500 1000; do
	#for per in 10; do
		size="/"$siz"/"
		folderPeriod=$path$size$per						# /home/jorlu/Escritorio/mqtt/test/512/10
		
		graphfolder=$folderPeriod"/"graphs
		mkdir $graphfolder

		for (( count=1; count<=10; count++ )) do
			# s512T10.out1.res
			fileName="s"$siz"T"$per".out"$count".res"		# filename = s512T10.out1
			file=$folderPeriod"/"$fileName
		
			#fileOutputSustract=$file".sus"
			#fileOutputSustractRes=$file".res"
			if [ -e $file ]; then
				echo "-----------------------------------------------"
				echo "SIZE: " $siz " PERIOD: " $per " TEST: " $count
				head -5 $file

				#establecemos la escala
				if [ $per -eq "10" ]; then
					xmax=1900
					#xmax=800 #zoom
				fi
				if [ $per -eq "100" ]; then
					xmax=200
				fi
				if [ $per -eq "500" ]; then
					xmax=40
				fi
				if [ $per -eq "1000" ]; then
					xmax=20
				fi

				xmin=0
				#xmin=300 #zoom
				#xmax=20
				ymin=-700
				ymax=4000

cd $graphfolder
#-------------------------------------------------------PLOT
#gnuplot -persist << EOF
gnuplot << EOF

set term postscript eps color blacktext "Helvetica" 16
set output "g_$fileName.eps"
set xlabel 'message'
set ylabel 'jitter (ms)'
#set key top left

#set title "MessageSize=$messageSize Period=$frecuency"

#plot [$xmin:$xmax] [$ymin:$ymax] "$file" u 1:2 title "test1" w linespoints
#plot [$xmin:$xmax] [$ymin:$ymax] "$file" u ($0+1):1 title "test1" w linespoints
plot [$xmin:$xmax] [$ymin:$ymax] "$file" title "test1" w linespoints

#plot [$xmin:$xmax] [$ymin:$ymax] "$nname" u 1:2 title "test1" w linespoints, \
#				"$file2" u 1:2 title "test2" w linespoints, \
#				"$file4" u 1:2 title "test4" w linespoints, \
#				"$file5" u 1:2 title "test5" w linespoints

set output
EOF

#--------------------------------------------------END--PLOT



			else
				echo -e "\n $file file not found"
			fi
	
		done
		#for count
	done 
	#for per
done 
#for siz
