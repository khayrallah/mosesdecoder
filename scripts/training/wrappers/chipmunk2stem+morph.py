
import sys

i = sys.argv[1] 
o_stem =  sys.argv[2] 
o_morph =  sys.argv[3] 


first =True
with open(o_stem,"w") as fout_stem:
  with open(o_morph,"w") as fout_morph:
    with open(i) as fin:
      for line in fin:
        line = line.split()
        if line[0] == "*END*":
            fout.write("\n")
            first = True
        else: 
          line = line[1:]
          words_stem = []
          words_morph = []
          for word in line:
            if first:
              first = False
            else:
              word = word.split(":")
              if "ROOT" in word[1]:
                words_stem += word[0]
              else: 
                words_morph += word[0]
          fout.write(" ".join(words))

    
