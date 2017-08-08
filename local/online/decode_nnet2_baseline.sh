#!/bin/bash

. cmd.sh


stage=1
train_stage=-10
use_gpu=true
. cmd.sh
. ./path.sh
. ./utils/parse_options.sh

 dir=exp/nnet_a_gpu_baseline

steps/online/nnet2/decode.sh --cmd "$decode_cmd" --nj 8 \
        --per-utt true \
        exp/tri4b/graph data/head_eval_test ${dir}_online/decode_utt || exit 1;

