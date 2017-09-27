#!/bin/bash

. ./path_config.sh

#utils/validate_data_dir.sh --no-feats $data
#utils/validate_data_dir.sh  --no-feats   $data/head_eval_test/clean

#utils/validate_data_dir.sh  $data/noisy
#utils/fix_data_dir.sh  $data/noisy

#utils/validate_data_dir.sh  --no-feats   $data

#utils/validate_data_dir.sh  --no-feats   $data/head_eval_test/noise
#data_prep/data_sort.sh $data

#utils/validate_data_dir.sh $data/split5utt/1
#utils/validate_data_dir.sh $data/split5utt/2
#utils/validate_data_dir.sh $data/split5utt/3
#utils/validate_data_dir.sh $data/split5utt/4
#utils/validate_data_dir.sh $data/split5utt/5
data=data/elg_utica/all

for i in $(seq 1 4);
do
	utils/subset_data_dir.sh --utt-list locs_$i.txt $data $data/loc_$i
done

#utils/combine_data.sh $data/train_1 $data/test_2 $data/test_3 \
#						$data/test_4 $data/test_5
#
#utils/combine_data.sh $data/train_2 $data/test_1 $data/test_3 \
#						$data/test_4 $data/test_5
#						
#utils/combine_data.sh $data/train_3 $data/test_1 $data/test_2 \
#						$data/test_4 $data/test_5
#						
#utils/combine_data.sh $data/train_4 $data/test_1 $data/test_2 \
#						$data/test_3 $data/test_5
#
#utils/combine_data.sh $data/train_5 $data/test_1 $data/test_2 \
#						$data/test_3 $data/test_4
#./data_sort.sh $data
##
#utils/validate_data_dir.sh --no-feats $data
#utils/split_data.sh --per-utt $data 5
#utils/combine_data.sh data/train_1234 $data/split5utt/1 $data/split5utt/2 \
#	$data/split5utt/3 $data/split5utt/4

#utils/combine_data.sh data/train_4 $data/split5utt/1 $data/split5utt/2 \
#	$data/split5utt/3 $data/split5utt/5
#	
#utils/combine_data.sh data/train_3 $data/split5utt/1 $data/split5utt/2 \
#	$data/split5utt/4 $data/split5utt/5
#	
#utils/combine_data.sh data/train_2 $data/split5utt/1 $data/split5utt/3 \
#	$data/split5utt/4 $data/split5utt/5
#
#utils/combine_data.sh data/train_1 $data/split5utt/2 $data/split5utt/3 \
#	$data/split5utt/4 $data/split5utt/5


	#x=all
#
#steps/make_mfcc.sh --cmd run.pl --nj 12 \
#   data/$x exp/make_mfcc/$x data/mfcc-$x || exit 1;
##   
#steps/compute_cmvn_stats.sh data/$x exp/cmvn_$x data/mfcc-$x || exit 1;
###
 #utils/validate_data_dir.sh data/head_eval_test

#cd data/head_eval_test
#
#utt2spk_to_spk2utt.pl utt2spk > spk2utt


#utils/validate_data_dir.sh --no-feats data/head_eval_test

#./data_sort.sh data/test
#data_prep/data_sort.sh $data/desk_test/noisy
#
#data_prep/data_sort.sh $data/desk_eval_test/noise
#data_prep/data_sort.sh $data/head_eval_test/noise
#data_prep/data_sort.sh $data/head_test/10dB
#data_prep/data_sort.sh $data/head_test/20dB
#data_prep/data_sort.sh $data/desk_test/clean
#data_prep/data_sort.sh $data/desk_test/5dB
#data_prep/data_sort.sh $data/desk_test/10dB
#data_prep/data_sort.sh $data/desk_test/20dB 
#data_prep/data_sort.sh $data/head_test/clean

#utils/fix_data_dir.sh  $data/train-wsj-pf-inc-noise
#utils/fix_data_dir.sh  $data/head_eval_test/5dB
#utils/fix_data_dir.sh  $data/head_eval_test/10dB
#utils/fix_data_dir.sh  $data/head_eval_test/20dB
#utils/fix_data_dir.sh  $data/desk_eval_test/clean
#utils/fix_data_dir.sh  $data/desk_eval_test/5dB
#utils/fix_data_dir.sh  $data/desk_eval_test/10dB
#utils/fix_data_dir.sh  $data/desk_eval_test/20dB 

#utils/fix_data_dir.sh $data/pf_desk_test
#utils/fix_data_dir.sh $data/pf_head_test

#utils/fix_data_dir.sh $data/test