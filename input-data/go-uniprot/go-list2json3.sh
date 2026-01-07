#!/bin/bash

# Produces json file with different coloring for is_a and part_of + regulates
# For use in https://amigo.geneontology.org/visualize?mode=client_amigo
# usage: go-list2json2.sh GO.is_a GO.others

grep -Eo 'GO:[0-9]{7}' desc_isa.txt > x1
grep -Eo 'GO:[0-9]{7}' desc_3rel.txt > x2

# Get unique GOs (not in is_a only)
grep -Fvf x1 x2 > x_uniq
# Get shared GOs
grep -Ff x1 x2 > x_share

# Prepare file for website
sed -e 's/^/"/; s/$/":{"fill": "#ccccff"},/' x_share > x3 # light violet
sed -e 's/^/"/; s/$/":{"fill": "#27F5D6"},/' x_uniq > x4 # cyan/green
cat x3 x4 | sed -e '1 s/^/{/; $ s/,$/}/' > ${1}.json

# rename file with all cats
mv x2 rel3_${1}.txt

rm x1 x3 x4 desc_isa.txt desc_3rel.txt
