#!/bin/bash

OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_`date +%R`.txt
CONF_FILE=$OUTPUT_DIRECTORY/configuration_`date +%R`.txt

touch $CONF_FILE
./scripts/read_configuration.sh >> $CONF_FILE

touch $OUTPUT_FILE
for i in 100 1000 10000 100000 250000 500000 750000 1000000; do
    for rep in `seq 1 5`; do
        echo "Size: $i" >> $OUTPUT_FILE;
        ./src/parallelQuicksort $i >> $OUTPUT_FILE;
    done ;
done
