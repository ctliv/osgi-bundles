#!/bin/bash

#script=$(basename ${BASH_SOURCE[0]})
#scriptname="${script%.*}"

basedir=$(dirname "$0")

if [ $# -ne 1 ]; then
	exit 1
fi

declare -a resources=(
"https://repo1.maven.org/maven2/org/jsoup/jsoup/1.11.3/jsoup-1.11.3.jar"
"https://repo1.maven.org/maven2/com/vaadin/external/gentyref/1.2.0.vaadin1/gentyref-1.2.0.vaadin1.jar"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-shared/${1}/vaadin-shared-${1}.jar"
"${basedir}/../vaadin-server-fix/get.sh ${1}"
"${basedir}/../vaadin-osgi-integration-fix/get.sh ${1}"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-client-compiled/${1}/vaadin-client-compiled-${1}.jar"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-themes/${1}/vaadin-themes-${1}.jar"
"${basedir}/../vaadin-liferay-integration-fix/get.sh ${1}"
)
