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


dir=exp/nnet_a_gpu_baseline

#utils/mkgraph.sh $lang exp/tri4b exp/tri4b/elg_graph

for n in `seq 1 4`;
do
	steps/online/nnet2/decode.sh --cmd "$decode_cmd" --nj 8 \
        --per-utt true \
        exp/tri4b/graph-elg-grammar data/elg_utica/all/loc_$n ${dir}_online/decode_loc_$n || exit 1;
done