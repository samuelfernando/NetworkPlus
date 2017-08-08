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
exp=exp
njobs=12
decode_jobs=12

# Now make MFCC features.
# mfccdir should be some place with a largish disk where you
# want to store MFCC features.


# Note: the --boost-silence option should probably be omitted by default
# for normal setups.  It doesn't always help. [it's to discourage non-silence
# models from modeling silence.]

#steps/align_fmllr.sh --nj $njobs --cmd "$train_cmd" \
#  $train $lang $exp/tri4b $exp/tri4b_ali || exit 1;
  
local/online/sam_run_nnet2_baseline.sh
#local/online/decode_nnet2_baseline.sh
