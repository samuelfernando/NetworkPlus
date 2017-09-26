#!/bin/bash

. cmd.sh
. path.sh


#utils/validate_data_dir.sh --no-feats $data
#utils/validate_data_dir.sh  --no-feats   $data/head_eval_test/clean

#utils/validate_data_dir.sh  $data/noisy
#utils/fix_data_dir.sh  $data/noisy

#utils/validate_data_dir.sh  --no-feats   $data

#utils/validate_data_dir.sh  --no-feats   $data/head_eval_test/noise
#data_prep/data_sort.sh $data
./data_sort.sh data/elg_utica/all
utils/validate_data_dir.sh --no-feats data/elg_utica/all

#steps/make_mfcc.sh --cmd "$train_cmd" --nj 12 \
#   data/head_eval_test exp/make_mfcc/head_eval_test data/mfcc-test-eval || exit 1;
# steps/compute_cmvn_stats.sh data/head_eval_test exp/make_mfcc/head_eval_test data/mfcc-test-eval || exit 1;
###
# utils/validate_data_dir.sh data/head_eval_test

steps/make_mfcc.sh --cmd "$train_cmd" --nj 12 \
   data/elg_utica/all exp/make_mfcc/all data/mfcc-all || exit 1;

steps/compute_cmvn_stats.sh data/elg_utica/all exp/make_mfcc/all data/mfcc-all || exit 1;

#cd data/head_eval_test
#
#utt2spk_to_spk2utt.pl utt2spk > spk2utt


#utils/validate_data_dir.sh --no-feats data/head_eval_test

#./data_sort.sh data/train
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