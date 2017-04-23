import sys

i = sys.argv[1] 
o =  sys.argv[2] 



first =True
with open(o,"w") as fout:
  with open(i) as fin:
    for line in fin:
      line = line.split()
      if line[0] == "*END*":
          fout.write("\n")
          first = True
      elif ":SPECIAL" in line:
        fout.write(line[0])
      else: 
        line = line[1:]
        words = []
        for word in line:
          if first:
            first = False
          else:
            fout.write(" ")
          words+= [word.split(":")[0]]
        fout.write(" ".join(words))

    
