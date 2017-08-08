#!/bin/bash

target=/scratch/samuel/wsjcam/dev_test

#mkdir -p $target/c2l

#/home/samuel/kaldi/tools/sph2pipe_v2.5/sph2pipe -f wav /home/samuel/network_plus_asr/data/si_tr/c2l/c2la010b.wv1 /scratch/samuel/wsjcam/train/c2l/c2la010b.wav

find /home/samuel/network_plus_asr/data/si_dt -name '*.wv1' -print0 | 
    while IFS= read -r -d $'\0' line; do 
       dirname=`dirname "$line"`
       fname=`basename "$line"`
       sub=`basename "$dirname"`
       root=`dirname "$dirname"`
       extension="${fname##*.}"
       filename="${fname%.*}"
       echo $filename.wav
       mkdir -p $target/$sub
       /home/samuel/kaldi/tools/sph2pipe_v2.5/sph2pipe -f wav $line $target/$sub/$filename.wav
    done

