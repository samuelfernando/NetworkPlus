#!/bin/bash

. cmd.sh
. path.sh

name=elg
model_dir=../exp/tri4b

#model_dir=../train/exp/tri4a
#model_dir=../online-models/offline_wsj_pfstar_tri4b
#model_dir=../online-models/tri4a-nnet-acoustic
graph=$model_dir/graph-$name-grammar
#graph=$model_dir/graph_commands


#name=pioneer
cd grammar

mkdir -p compiled
mkdir -p tmp_lang

#./jsgf_to_fsm.sh $name
#./fsm_to_fst.sh $name
#./make_grammar_lang.sh $name
#./my-mkgraph.sh tmp_lang $model_dir $graph



