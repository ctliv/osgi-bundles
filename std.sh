#!/bin/bash

path=$(dirname "$0")

echo

"${path}/deploy.sh" $* "${path}/webconsole/webconsole-4.3.4.sh" "${path}/webconsole/search-webconsole-plugin-1.2.1.sh" "${path}/vaadin/vaadin-8.2.0.sh" "${path}/autocomplete-bundle/autocomplete-bundle-0.2.2.sh" "${path}/geolocation-bundle/geolocation-bundle-0.1.0.sh" "${path}/vaadin-onoffswitch-bundle/vaadin-onoffswitch-bundle-1.1.0.sh" "${path}/report-ui-full-bundle/report-ui-full-bundle-1.1.sh"

