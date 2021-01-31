#!/bin/sh

if [ $# != 1 ]; then
    echo "ERROR args nums: $*"
    echo "Please set module path"
    exit 1
fi

MODULE_PATH=$1

mkdir -p $MODULE_PATH

touch $MODULE_PATH/main.tf
touch $MODULE_PATH/variables.tf
touch $MODULE_PATH/outputs.tf
