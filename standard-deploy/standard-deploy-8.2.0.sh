#!/bin/bash

basedir=$(dirname "$0")

declare -a resources=(
"${basedir}/../vaadin-fix/vaadin-fix.sh 8.2.0"
"${basedir}/../autocomplete-bundle/autocomplete-bundle.sh 0.2.2"
"${basedir}/../geolocation-bundle/geolocation-bundle-0.1.0.sh"
"${basedir}/../vaadin-onoffswitch-bundle/vaadin-onoffswitch-bundle-1.1.0.sh"
"${basedir}/../formcheckbox-bundle/formcheckbox-bundle-1.0.2.sh"
"${basedir}/../report-ui-full-bundle/report-ui-full-bundle-1.1.sh"
"${basedir}/../vaadin-sliderpanel-bundle/get.sh 2.2.0"
)

