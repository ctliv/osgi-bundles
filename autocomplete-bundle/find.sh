#!/bin/bash

realname=$(realpath ${BASH_SOURCE[0]})
scriptpath=$(dirname ${realname})
scriptdir=$(basename ${scriptpath})

if [ $# -ne 1 ]; then
	exit 1
fi

declare -a resources=(
"target-${1}/${scriptdir}-${1}.jar"
)

