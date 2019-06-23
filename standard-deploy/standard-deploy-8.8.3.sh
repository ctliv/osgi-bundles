#!/bin/bash

basedir=$(dirname "$0")

declare -a resources=(
"${basedir}/../hibernate-validator-bundle/get.sh 5.3.6.Final"
"${basedir}/../vaadin/vaadin-fix.sh 8.8.3"
"${basedir}/../autocomplete-bundle/get.sh 0.2.4"
"${basedir}/../geolocation-bundle/get.sh 0.1.0"
"${basedir}/../formcheckbox-bundle/get.sh 1.0.2"
"${basedir}/../report-ui-full-bundle/get.sh 1.1"
)

