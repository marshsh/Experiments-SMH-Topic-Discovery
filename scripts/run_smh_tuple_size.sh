#!/bin/bash
#
# Script to discover topics with SMH using different tuple sizes (2, 3 and 4)
#
# It receives directory for SMH experiments as argument
TWENTY=false
REUTERS=false

while getopts ":tr" opt; do
    case $opt in
        t )
            TWENTY=true
            echo "Using 20 NewsGroups corpus."
            ;;
        r )
            REUTERS=true
            echo "Using Reuters corpus."
            ;;
        ? )
            TWENTY=true
            echo "Using DEFAULT corpus: 20 NewsGroups."
            ;;            
    esac
done





for TUPLE_SIZE in 2 3 4
do
    if $TWENTY; then
        echo "Discovering topics for 20 NewsGroups corpus with SMH (tuple size = $TUPLE_SIZE)"
        mkdir -p $1/20newsgroups/tuple_size
        python python/discovery/smh_topic_discovery.py \
            --tuple_size $TUPLE_SIZE \
            --cooccurrence_threshold 0.08 \
            --corpus data/20newsgroups/20newsgroups40000.corpus \
            --overlap 0.90 \
            --min_set_size 3 \
            data/20newsgroups/20newsgroups40000.ifs \
            data/20newsgroups/20newsgroups40000.vocab \
            $1/20newsgroups/tuple_size/
    fi

    if $REUTERS; then
        echo "Discovering topics for REUTERS corpus with SMH (tuple size = $TUPLE_SIZE)"
        mkdir -p $1/reuters/tuple_size
        python python/discovery/smh_topic_discovery.py \
            --tuple_size $TUPLE_SIZE \
            --cooccurrence_threshold 0.08 \
            --corpus data/reuters/reuters100000.corpus \
            --overlap 0.90 \
            --min_set_size 3 \
            data/reuters/reuters100000.ifs \
            data/reuters/reuters100000.vocab \
            $1/reuters/tuple_size/
    fi
done
