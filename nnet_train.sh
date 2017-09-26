#!/bin/bash

# This is the training portion of the WSJ recipe (need to run mfcc.sh first)

#wsj1=/data/corpora0/LDC94S13B
#. que_config.sh
. cmd.sh
. path.sh


if $use_gpu; then
  if ! cuda-compiled; then
    cat <<EOF && exit 1 
This script is intended to be used with GPUs but you have not compiled Kaldi with CUDA 
If you want to use GPUs (and have them), go to src/, and configure and make on a machine
where "nvcc" is installed.  Otherwise, call this script with --use-gpu false
EOF
  fi
  parallel_opts="-l gpu=1" 
  num_threads=1
  minibatch_size=512
  # the _a is in case I want to change the parameters.
else
  # Use 4 nnet jobs just like run_4d_gpu.sh so the results should be
  # almost the same, but this may be a little bit slow.
  num_threads=16
  minibatch_size=128
  parallel_opts="-pe smp $num_threads" 
  dir=exp/nnet2_online/nnet_a_baseline
fi


train_cmd=run.pl
decode_cmd=run.pl
model_dir=exp/tri4a
graph=online-models/kaldi-graph-kitchen
njobs=4

lang=data/lang_test
decode_jobs=4

for n in `seq 2 5`;
do

train=data/elg_utica/all/train_$n
test=data/elg_utica/all/test_$n
dir=exp/nnet2_online/nnet_a_gpu_scratch_$n

train_stage=-10

steps/align_fmllr.sh --nj $njobs --cmd "$train_cmd" \
  $train $lang exp/tri4b exp/tri4b_ali_elg_$n || exit 1;
 
steps/train_sat.sh  --cmd "$train_cmd" \
  4200 40000 $train $lang exp/tri4b_ali_elg_$n exp/tri5a_$n || exit 1;

utils/mkgraph.sh grammar/tmp_lang exp/tri5a_$n exp/tri5a_$n/graph-grammar || exit 1;

steps/decode_fmllr.sh --nj $decode_jobs --cmd "$decode_cmd" \
	exp/tri5a_$n/graph-grammar $test exp/tri5a_$n/decode-grammar || exit 1;

steps/align_fmllr.sh --nj $njobs --cmd "$train_cmd" \
  $train $lang exp/tri5a exp/tri5a_ali_elg_$n || exit 1;

steps/nnet2/train_pnorm_fast.sh --stage $train_stage \
   --num-epochs 8 --num-epochs-extra 4 \
   --splice-width 7 --feat-type raw \
   --cmvn-opts "--norm-means=false --norm-vars=false" \
   --num-threads "$num_threads" \
   --minibatch-size "$minibatch_size" \
   --parallel-opts "$parallel_opts" \
   --num-jobs-nnet 6 \
   --num-hidden-layers 4 \
   --mix-up 4000 \
   --initial-learning-rate 0.02 --final-learning-rate 0.004 \
   --cmd "$decode_cmd" \
   --pnorm-input-dim 2400 \
   --pnorm-output-dim 300 \
   $train data/lang_test exp/tri5a_ali_elg_$n $dir  || exit 1;
         
steps/online/nnet2/prepare_online_decoding.sh data/lang_test "$dir" ${dir}_online || exit 1;

steps/online/nnet2/decode.sh --cmd "$decode_cmd" --nj 8 \
        --per-utt true \
        exp/tri5a/graph-grammar $test ${dir}_online/decode_elg_grammar || exit 1;
done