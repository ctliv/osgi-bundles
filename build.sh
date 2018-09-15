#!/bin/bash

script=$(basename ${BASH_SOURCE[0]})
scriptPath=$(dirname "$script")
scriptAbs=$(realpath "$script")
scriptAbsPath=$(dirname "$scriptAbs")
scriptName="${script%.*}"
scriptExt="${scriptName##*.}"

showhelp () {
	echo
	echo "USAGE: $scriptName [<version>]"
	echo
	exit 1
}

if [ $# -gt 1 ]; then
	echo "Illegal number of parameters"
    showhelp
fi

if [ "$1" != "" ]; then
	echo
	echo Changing version to $1
	echo
	mvn versions:set -DnewVersion="$1"
	echo
	echo Version changed to $1
	echo
fi
mvn clean install

echo
echo Build completed

