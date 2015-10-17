#!/bin/bash

CORES=7
OUTPUT=${OUTPUT:-results}

array=(
    AssignmentTwo
#    ContinuousPeaksTest
#    CountOnesTest
#    FlipFlopTest
#    FourPeaksTest
#    KnapsackTest
)

mkdir -p ${OUTPUT}

count=0

function set_header {
    if [[ $1 = "AssignmentTwo" ]]; then
        echo "algorithm,iterations,training error,testing error,training time,testing time" > ${OUTPUT}/${1}.csv
    else
        echo "algorithm,iterations,time,optim" > ${OUTPUT}/${1}.csv
    fi
}

for j in "${array[@]}";do
    for i in 1 100 1000 10000 100000 1000000;do
        count=$((count+1))

        if [[ $count -eq 0 ]]; then
            set_header ${j}
        fi

        java -cp ABAGAIL.jar opt.test.${j} ${i} >| /tmp/${j}${i}.csv &

        if [[ $(expr $count % ${CORES}) -eq 0 ]]; then
            # wait for cores to free up
            wait
        fi
    done
    # catch overflow
    wait
    cat /tmp/${j}*.csv >> ${OUTPUT}/${j}.csv
    rm -f /tmp/${j}*.csv
done


