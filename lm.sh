#!/bin/bash

. path.sh
. cmd.sh


#local/make_beep_dict.sh

#cp data/wsj/local/dict/*silence_phones.txt data/local/dict

#utils/prepare_lang.sh data/local/dict "<UNK>" data/local/lang data/lang

#local/my_train_lms.sh
local/my_create_test_lang.sh