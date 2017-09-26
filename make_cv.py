# assumes as input a validated data folder
import re
from os.path import join, exists
from random import randint
from os import mkdir

srcdir="data/elg_utica/all"
utts = {}
utt_pat = re.compile("(\S+) .*")
f = open(join(srcdir, "text"))

count = {}
for i in range(1,6):
	count[i] = 0

for line in f.readlines():
	line = line.strip()
	res = utt_pat.match(line)
	if res:
		utt_id = res.group(1)
		x = randint(1,5)
		while count[x]>=39:
			x = randint(1,5)
		utts[utt_id] = x
		count[x] = count[x] + 1
		
fs = {}
for i in range(1, 6):
	fs[i] = open("utts_"+str(i)+".txt", "w")

for utt_id in utts:
	n = utts[utt_id]
	fs[n].write(utt_id+"\n")

