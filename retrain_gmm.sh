#!/bin/bash

# This is the training portion of the WSJ recipe (need to run mfcc.sh first)

#wsj1=/data/corpora0/LDC94S13B
#. que_config.sh
. ./path_config.sh

#lang=wsj-pfstar-with-eval
#lang=data/lang_test
##lang=/scratch/samuel/miro_wsj/data/lang_test_tgpr_5k
#train=data/train
#test=data/head_eval_test
#exp=exp
#njobs=12
#decode_jobs=12
#
 
train_cmd=run.pl
decode_cmd=run.pl
model_dir=online-models/offline-tri4a-acoustic
graph=online-models/kaldi-graph-kitchen
#echo "$0: dumping activations from WSJ model" 
#steps/online/nnet2/dump_nnet_activations.sh --cmd "run.pl" --nj 17 \
#     data/train $srcdir $trainfeats
njobs=8

lang=data/lang_test
decode_jobs=8
#steps/align_fmllr.sh --nj $njobs --cmd "$train_cmd" \
#  data/train $lang $model_dir exp/tri4a_ali || exit 1;
#
#
#steps/train_sat.sh  --cmd "$train_cmd" \
#  4200 40000 data/train $lang exp/tri4a_ali exp/tri4a || exit 1;
# 
#utils/mkgraph.sh $lang exp/tri4a exp/tri4a/graph || exit 1;

#steps/decode_fmllr.sh --nj $decode_jobs --cmd "$decode_cmd" \
#   exp/tri4a/graph data/test exp/tri4a/decode || exit 1;

exp=exp
train=data/elg_utica/all/train_1
test=data/elg_utica/all/test_1


#steps/align_fmllr.sh --nj $njobs --cmd "$train_cmd" \
 # $train $lang exp/tri4b exp/tri4b_ali_elg || exit 1;


#steps/train_sat.sh  --cmd "$train_cmd" \
#  4200 40000 $train $lang exp/tri4b_ali_elg exp/tri5a || exit 1;

utils/mkgraph.sh grammar/tmp_lang exp/tri5a exp/tri5a/graph-grammar || exit 1;
steps/decode_fmllr.sh --nj $decode_jobs --cmd "$decode_cmd" \
   exp/tri5a/graph-grammar $test exp/tri5a/decode-grammar || exit 1;

         
         
