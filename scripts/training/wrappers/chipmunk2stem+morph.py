
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
            fout_stem.write("\n")
            fout_morph.write("\n")
            first = True
        elif line[0] ==":":
          fout_stem.write(" :")
          fout_morph.write(" :")
        else: 
          line = line[1:]
          if first:
            words_stem = []
            words_morph = []
            first = False
          else:
            words_stem = [" "]
            words_morph = [" "]
          for word in line:
            #if first:
            #  first = False
            #else:
            word = word.split(":")
            if "ROOT" in word[1] or "SPECIAL" in word[1]:
              words_stem += word[0]
            else: 
              words_morph += word[0]
          if words_stem == [" "] or words_stem == []:
            words_stem = words_morph
          if words_morph == [" "] or  words_morph == []:
            words_morph = words_stem
          fout_stem.write("".join(words_stem))
          fout_morph.write("".join(words_morph))

    
