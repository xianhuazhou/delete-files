#!/bin/bash

TARGET_DIR=$1

if [[ $TARGET_DIR == '' ]]
then
    echo "Usage: bash `basename "$0"` <dir> [--verbose]"
    exit 0 
fi

if [[ ! -d $TARGET_DIR ]]
then
    echo "The dir ${TARGET_DIR} doesn't exists."
    exit -1
fi

verbose=false
if [[ $2 == '--verbose' ]]
then
    verbose=true
fi

echo -n "Are you sure to delete all the files in \"${TARGET_DIR}\" [Y|n]: "

read confirm

if [[ $confirm != 'Y' ]]
then
    echo "Do nothing."
    exit
fi

start_time=`date -u +'%s'`

PREFIX='__'
_TMP_DIR=/tmp/${PREFIX}delete_lots_small_files_`date +'%Y%m%d%H%M%I'`

[[ -d $_TMP_DIR ]] && rm -rf $TMP_DIR
mkdir $_TMP_DIR
cd $_TMP_DIR

echo "Collecting files to delete with find ..."

nice -n 19 find $TARGET_DIR -type f > _
num_files=`wc -l < _`
split _ $PREFIX

if [[ $num_files == '0' ]]
then
    echo "The dir ${TARGET_DIR} is empty.";
    echo "Do nothing."
    exit;
fi

echo "Deleting files in ${TARGET_DIR} ..."

deleted_lines=0
for d in `ls ${PREFIX}*`
do
    for f in `cat $d`
    do
        if [[ $with_logs == true ]]
        then
            echo $f
        fi

        rm $f
    done

    lines=`wc -l < ${d}`
    deleted_lines=$(( deleted_lines + lines ))

    echo "${deleted_lines}/${num_files}"

    rm $d
    sleep 0.01
done

end_time=`date -u +'%s'`

echo "Deleted number of files: ${num_files}, Time: $(( end_time - start_time )) seconds."
echo "Done."

# clean up
rm -rf $TARGET_DIR/*
