from os.path import join, exists
import re

recs = open("rec_ids.txt")

path = "/home/samf/Music/elg_utica/transcripts"
wav = "/home/samf/Music/elg_utica/ELG_Audio/16kHz"
pat=re.compile("(\d+.\d+) (\d+.\d+) \w+: (.*)")
utt_pat = re.compile("(\S+) .*")

seg_out = {}
wav_out = {}
spk_out = {}
text_out = {}
test_utts = {}

def read_test():
	f = open("test_utts.txt")
	for line in f.readlines():
		line = line.strip()
		res = utt_pat.match(line)
		if res:
			utt_id = res.group(1)
			test_utts[utt_id] = 1			
		
def open_files():
#	dirs = ["all", "train", "test"]
	dirs = ["all"]
	for dirname in dirs:
		seg_out[dirname]=open("data/elg_utica/"+dirname+"/segments.unsorted", "w")
		wav_out[dirname]=open("data/elg_utica/"+dirname+"/wav.scp.unsorted", "w")
		spk_out[dirname]=open("data/elg_utica/"+dirname+"/utt2spk.unsorted", "w")
		text_out[dirname]=open("data/elg_utica/"+dirname+"/text.unsorted", "w")

def check():
	for line in recs.readlines():
		rec_id = line.strip()
		full = join(path, rec_id+".tdf.txt")
		if not exists(full):
			print("No "+full)

def write(utt_id, start, end, utt):
	text_out["all"].write(utt_id+" "+utt+"\n")
	seg_out["all"].write(utt_id+" "+rec_id+" "+start+" "+end+"\n")
	spk_out["all"].write(utt_id+" "+rec_id+"\n")
	#if utt_id in test_utts:
	#	text_out["test"].write(utt_id+" "+utt+"\n")
	#	seg_out["test"].write(utt_id+" "+rec_id+" "+start+" "+end+"\n")
	#	spk_out["test"].write(utt_id+" "+rec_id+"\n")
	#else:
	#	text_out["train"].write(utt_id+" "+utt+"\n")
	#	seg_out["train"].write(utt_id+" "+rec_id+" "+start+" "+end+"\n")
	#	spk_out["train"].write(utt_id+" "+rec_id+"\n")
		
	
def proc(rec_id, text_file):
	f = open(join(path, text_file))
	lines = f.readlines()
	wav_path=join(wav, rec_id+".wav")
	wav_out["all"].write(rec_id + " "+wav_path+"\n")
	#wav_out["test"].write(rec_id + " "+wav_path+"\n")
	#wav_out["train"].write(rec_id + " "+wav_path+"\n")

	for line in lines:
		line = line.strip()
		res = pat.match(line)
		if res:
			start = res.group(1)
			end = res.group(2)
			utt = res.group(3)
			utt_id = rec_id+"-"+start+"-"+end
			utt = utt.replace("_", ".")	
			utt = utt.upper()
			write(utt_id, start, end, utt)	
		
open_files()
#check()
for line in recs.readlines():
	rec_id = line.strip()
	text_file = rec_id+".tdf.txt"
	proc(rec_id, text_file)