in = sys.argv[1] 
out =  sys.argv[2] 
first =True



with open(out,"w") as fout:
  with open(in) as fin:
    for line in fin:
      line = line.split()
      if line[0] == "*END*":
          out.write("\n")
          first = True
      else: 
        if first:
          out.write(" ")
          first = False
        line = line[1:]
        words = []
        for word in line:
          words+= [word.split(":")[0]]
        out.write(" ".join(words))

    
