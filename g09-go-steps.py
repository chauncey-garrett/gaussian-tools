#!/usr/bin/env python3
#
# Obtain the all Cartesian coordinates of a Gaussian output file as a trajectory
#

# Load sys to additional input in the line
import sys, os

# Set global variables
start = []
end = []
elements = ["", "H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar", "K", "Ca", "Sc", "Ti", "V", "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge", "As", "Se", "Br", "Kr", "Rb", "Sr", "Y", "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn", "Sb", "Te", "I", "Xe", "Cs", "Ba", "La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Hf", "Ta", "W", "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb", "Bi", "Po", "At", "Rn", "Fe", "Ra", "Ac", "Th", "Pa", "U", "Np", "Pu", "Am", "Cm", "Bk", "Cf", "Es", "Fm", "Md", "No", "Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Cn", "Uut", "Fl", "Uup", "Lv", "Uus", "Uuo"]

# Receive the Gaussian input file
filename = sys.argv[1]

# cut extension and add xyz
newfile = os.path.splitext(filename)[0] + ".xyz"

# Open the original file in read mode
openold = open(filename,"r")

# Create a new file with writing rights
# overwrites old file!!
opennew = open(newfile,"w")

# Read the entire original file
rline = openold.readlines()

for i in range(len(rline)):
    if "Standard orientation:" in rline[i]:
        start.append(i)
        for m in range (start[-1] + 5, len(rline)):
            if "---" in rline[m]:
                end.append(m)
                break

# Convert to formatted Cartesian coordinates
for i,iStart in enumerate(start):
   nAtoms = end[i] - (start[i]+5)
   opennew.write(str(nAtoms))
   opennew.write('\n\n')
   for line in rline[start[i]+5 : end[i]] :
      words = line.split()
      word1 = elements[int(words[1])]
      opennew.write("{:10}  {:}\n".format(word1,line[30:-1]))

openold.close()
opennew.close()
