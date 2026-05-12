#!/bin/bash
read -p "Do you want to clear previous data? (y/n)" yn
#case $yn in
#    [yY] ) echo "Removing data";rm data/*; break;;
#    [nN] ) break;;
#esac
set -e
module load aocc/5.0.0
module load aocl/5.0.0
sbcl --dynamic-space-size 20000 --load "build_step.lisp" --quit
set +e

export AGG=TRUE
export NAME=LSTP_NEW
export MPS=2
rm data_$NAME.csv
export REFINE=6
for s in DR
do
    export SOLVER=$s
    for l in 1 2 4 8 16 32 64 128 256 512
    do
        export LSTPS=$l
        sbatch bacolumn.sh
    done
done

#for s in DR IMPLICIT
#do
#    export SOLVER=$s
#    for l in 30 48 50
#    do
#        export LSTPS=$l
#        sbatch bacolumn.sh
#    done
#done
