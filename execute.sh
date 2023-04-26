#!/bin/sh

if [ $# -ne "2" ]; then
    echo "First Arguments <init|plan|validate|apply|destroy> and Second Arguments <production|staging|development> are required!!!"
    exit 1
fi

OPERATION=$1
ENV=$2
cd ./resources/${ENV} && terragrunt run-all ${OPERATION}