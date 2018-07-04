#!/bin/bash

basedir=$(dirname "$0")

declare -a resources=(
"${basedir}/../webconsole/webconsole-4.3.4.sh"
"${basedir}/../webconsole/search-webconsole-plugin-1.2.1.sh"
"${basedir}/../vaadin-fix/vaadin-8.2.0-fix.sh"
"${basedir}/../autocomplete-bundle/autocomplete-bundle-0.2.2.sh"
"${basedir}/../geolocation-bundle/geolocation-bundle-0.1.0.sh"
"${basedir}/../vaadin-onoffswitch-bundle/vaadin-onoffswitch-bundle-1.1.0.sh"
"${basedir}/../formcheckbox-bundle/formcheckbox-bundle-1.0.2.sh"
"${basedir}/../report-ui-full-bundle/report-ui-full-bundle-1.1.sh"
)

