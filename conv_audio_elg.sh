#!/bin/bash

target=/scratch/samuel/wsjcam/dev_test



cd /home/samf/Music/elg_utica/ELG_Audio/proc
mkdir -p ../16kHz/emp1
mkdir -p ../16kHz/emp2
mkdir -p ../16kHz/emp3


for f in emp*/*.wav; do
	sox -v 0.95 $f -r 16000 ../16kHz/$f
done
		