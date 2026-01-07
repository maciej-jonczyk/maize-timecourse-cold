#!/bin/bash

# Produces json file with different coloring for is_a and part_of + regulates
# For use in https://amigo.geneontology.org/visualize?mode=client_amigo
# usage: go-list2json2.sh GO.is_a GO.others


sed -e 's/^/"/; s/$/":{"fill": "#ccccff"},/' $1> x1 # light violet
sed -e 's/^/"/; s/$/":{"fill": "#27F5D6"},/' $2> x2 # cyan/green
cat x1 x2 | sed -e '1 s/^/{/; $ s/,$/}/' > ${1}.${2}.json


