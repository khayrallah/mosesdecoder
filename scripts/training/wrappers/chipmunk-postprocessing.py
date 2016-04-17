import sys

i = sys.argv[1] 
o =  sys.argv[2] 




with open(o,"w") as fout:
  with open(i) as fin:
    for line in fin:
      first =True
      line = line.split()
      if line[0] == "*END*":
          fout.write("\n")
          first = True
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

    
