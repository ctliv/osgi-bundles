#!/bin/bash

basedir=$(dirname "$0")

declare -a resources=(
"${basedir}/../vaadin-fix/vaadin-fix.sh 8.5.2"
"${basedir}/../autocomplete-bundle/find.sh 0.2.4"
"${basedir}/../geolocation-bundle/find.sh 0.1.0"
"${basedir}/../vaadin-onoffswitch-bundle/find.sh 1.1.0"
"${basedir}/../formcheckbox-bundle/find.sh 1.0.2"
"${basedir}/../report-ui-full-bundle/report-ui-full-bundle-1.1.sh"
)

