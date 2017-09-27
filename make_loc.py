# assumes as input a validated data folder
import re
from os.path import join, exists
from random import randint
from os import mkdir

srcdir="data/elg_utica/all"
utts = {}
loc_pat = re.compile(".*loc(\d)-.*")
utt_pat = re.compile("(\S+) .*")
f = open(join(srcdir, "text"))
fs = {}

for line in f.readlines():
	line = line.strip()
	res = loc_pat.match(line)
	if res:
		loc_id = res.group(1)
		r = utt_pat.match(line)
		if r:
			utt_id = r.group(1)
			utts[utt_id] = loc_id
		
for i in range(1, 5):
	fs[i] = open("locs_"+str(i)+".txt", "w")

for utt_id in utts:
	n = int(utts[utt_id])
	fs[n].write(utt_id+"\n")

