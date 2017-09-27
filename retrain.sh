#!/bin/bash

# This is the training portion of the WSJ recipe (need to run mfcc.sh first)

#wsj1=/data/corpora0/LDC94S13B
#. que_config.sh
. cmd.sh
. path.sh

#lang=wsj-pfstar-with-eval
#lang=data/lang_test
##lang=/scratch/samuel/miro_wsj/data/lang_test_tgpr_5k
#train=data/train
#test=data/head_eval_test
#exp=exp
#njobs=12
#decode_jobs=12
#
model_dir=online-models/offline-tri4a-acoustic
#graph=online-models/kaldi-graph-kitchen

#dir=online-models/nnet_noisy_online
# Now make MFCC features.
# mfccdir should be some place with a largish disk where you
# want to store MFCC features.

stage=0
train_stage=-10
use_gpu=true

if ! cuda-compiled; then
    cat <<EOF && exit 1
This script is intended to be used with GPUs but you have not compiled Kaldi with CUDA
If you want to use GPUs (and have them), go to src/, and configure and make on a machine
where "nvcc" is installed.  Otherwise, call this script with --use-gpu false
EOF
  fi
 
parallel_opts="--gpu 1"
num_threads=1
minibatch_size=512
#trainfeats=exp/nnet2_online_wsj/wsj_activations_train

srcdir=exp/nnet_a_gpu_baseline_online
trainfeats=$srcdir/activations

dir=exp/elg_retrain1_online

train_cmd=run.pl
data=data/elg_utica/all

train=$data/train_1
lang=data/lang_test
njobs=8

#echo "$0: dumping activations from WSJ model" 
#steps/online/nnet2/dump_nnet_activations.sh --cmd "run.pl" --nj 8 \
 #    $train $srcdir $trainfeats


# Note: the --boost-silence option should probably be omitted by default
# for normal setups.  It doesn't always help. [it's to discourage non-silence
# models from modeling silence.]

#steps/align_fmllr.sh --nj $njobs --cmd "$train_cmd" \
#  $train $lang exp/tri4b exp/tri4b_ali_elg || exit 1;
  
#local/online/sam_run_nnet2_baseline.sh
#local/online/decode_nnet2_baseline.sh


steps/nnet2/retrain_fast.sh --stage $train_stage \
    --num-threads "$num_threads" \
    --minibatch-size "$minibatch_size" \
    --parallel-opts "$parallel_opts" \
    --cmd "run.pl" \
    --num-jobs-nnet 4 \
    --mix-up 4000 \
    --initial-learning-rate 0.02 --final-learning-rate 0.004 \
     $trainfeats/data $lang exp/tri4b_ali_elg $dir
#
#     
#     steps/online/nnet2/prepare_online_decoding_retrain.sh $srcdir $dir ${dir}_online
#rm -rf $graph
#
#utils/mkgraph.sh $lang $model_dir $graph
#steps/online/nnet2/decode.sh --cmd run.pl --nj 8 \
#        --per-utt true \
#         $graph data/test ${dir}/decode_utt || exit 1;
         
         
