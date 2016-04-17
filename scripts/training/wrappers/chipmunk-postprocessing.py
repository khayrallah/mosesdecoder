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
      else: 
        if first:
          fout.write(" ")
          first = False
        line = line[1:]
        words = []
        for word in line:
          words+= [word.split(":")[0]]
        fout.write(" ".join(words))

    
