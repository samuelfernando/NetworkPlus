#!/bin/bash

# This is the training portion of the WSJ recipe (need to run mfcc.sh first)

#wsj1=/data/corpora0/LDC94S13B
#. que_config.sh
. cmd.sh
. path.sh

#lang=wsj-pfstar-with-eval
lang=data/wsj/lang_test
#lang=/scratch/samuel/miro_wsj/data/lang_test_tgpr_5k
test=data/wsj/head_eval_test

dir=exp/nnet_a_gpu_baseline

#utils/mkgraph.sh $lang exp/tri4b exp/tri4b/elg_graph

steps/online/nnet2/decode.sh --cmd "$decode_cmd" --nj 1 \
        --per-utt true \
        exp/tri4b/graph $test ${dir}_online/decode_wsj || exit 1;
