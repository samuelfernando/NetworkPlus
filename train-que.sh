#!/bin/bash

# This is the training portion of the WSJ recipe (need to run mfcc.sh first)

#wsj1=/data/corpora0/LDC94S13B
#. que_config.sh
. cmd.sh
. path.sh

#lang=wsj-pfstar-with-eval
lang=data/lang_test
#lang=/scratch/samuel/miro_wsj/data/lang_test_tgpr_5k
train=data/train
test=data/head_eval_test
exp=exp-kaldi-lang
njobs=12
decode_jobs=12

# Now make MFCC features.
# mfccdir should be some place with a largish disk where you
# want to store MFCC features.


# Note: the --boost-silence option should probably be omitted by default
# for normal setups.  It doesn't always help. [it's to discourage non-silence
# models from modeling silence.]

utils/subset_data_dir.sh --shortest data/train 2000 data/train_2kshort || exit 1;

steps/train_mono.sh --nj $njobs --cmd "$train_cmd" \
  data/train_2kshort $lang $exp/mono0a || exit 1;

utils/mkgraph.sh --mono $lang $exp/mono0a $exp/mono0a/graph && \
steps/decode.sh --nj $njobs --cmd "$decode_cmd" \
      $exp/mono0a/graph $test $exp/mono0a/decode
    
steps/align_si.sh --nj $njobs --cmd "$train_cmd" \
   $train $lang $exp/mono0a $exp/mono0a_ali || exit 1;

steps/train_deltas.sh --cmd "$train_cmd" \
    2000 10000 $train $lang $exp/mono0a_ali $exp/tri1 || exit 1;

 utils/mkgraph.sh $lang $exp/tri1 $exp/tri1/graph || exit 1;

steps/decode.sh --nj $njobs --cmd "$decode_cmd" \
      $exp/tri1/graph $test $exp/tri1/decode 

steps/align_si.sh --nj $njobs --cmd "$train_cmd" \
  $train $lang $exp/tri1 $exp/tri1_ali || exit 1;

steps/train_lda_mllt.sh --cmd "$train_cmd" \
   --splice-opts "--left-context=3 --right-context=3" \
   2500 15000 $train $lang $exp/tri1_ali $exp/tri2b || exit 1;

utils/mkgraph.sh $lang $exp/tri2b $exp/tri2b/graph || exit 1;
steps/decode.sh --nj $decode_jobs --cmd "$decode_cmd" \
  $exp/tri2b/graph $test $exp/tri2b/decode || exit 1;



steps/align_si.sh  --nj $njobs --cmd "$train_cmd" \
  --use-graphs true $train $lang $exp/tri2b $exp/tri2b_ali  || exit 1;


steps/train_sat.sh --cmd "$train_cmd" \
  2500 15000 $train $lang $exp/tri2b_ali $exp/tri3b || exit 1;
utils/mkgraph.sh $lang $exp/tri3b $exp/tri3b/graph || exit 1;
steps/decode_fmllr.sh --nj $decode_jobs --cmd "$decode_cmd" \
  $exp/tri3b/graph $test $exp/tri3b/decode || exit 1;

utils/mkgraph.sh $lang $exp/tri3b $exp/tri3b/graph || exit 1;

steps/decode_fmllr.sh --cmd "$decode_cmd" --nj $decode_jobs \
  $exp/tri3b/graph $test $exp/tri3b/decode || exit 1;

steps/align_fmllr.sh --nj $njobs --cmd "$train_cmd" \
  $train $lang $exp/tri3b $exp/tri3b_ali || exit 1;


# From 3b system, train another SAT system (tri4a) with all the si284 $data.

steps/train_sat.sh  --cmd "$train_cmd" \
  4200 40000 $train $lang $exp/tri3b_ali $exp/tri4a || exit 1;

 utils/mkgraph.sh $lang $exp/tri4a $exp/tri4a/graph || exit 1;
 steps/decode_fmllr.sh --nj $decode_jobs --cmd "$decode_cmd" \
   $exp/tri4a/graph $test $exp/tri4a/decode || exit 1;
 


# This step is just to demonstrate the train_quick.sh script, in which we
# initialize the GMMs from the old system's GMMs.
steps/train_quick.sh --cmd "$train_cmd" \
   4200 40000 $train $lang $exp/tri3b_ali $exp/tri4b || exit 1;


 utils/mkgraph.sh $lang $exp/tri4b $exp/tri4b/graph || exit 1;
 steps/decode_fmllr.sh --nj $decode_jobs --cmd "$decode_cmd" \
   $exp/tri4b/graph $test $exp/tri4b/decode || exit 1;
 
steps/align_fmllr.sh --nj $njobs --cmd "$train_cmd" \
  $train $lang $exp/tri4b $exp/tri4b_ali || exit 1;

