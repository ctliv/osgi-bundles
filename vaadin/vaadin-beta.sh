#!/bin/bash

#script=$(basename ${BASH_SOURCE[0]})
#scriptname="${script%.*}"

basedir=$(dirname "$0")

mvnRoot="https://repo1.maven.org/maven2"
repoRoot="http://maven.vaadin.com/vaadin-prereleases"

if [ $# -ne 1 ]; then
	exit 1
fi

declare -a resources=(
"${mvnRoot}/org/jsoup/jsoup/1.11.3/jsoup-1.11.3.jar"
"${mvnRoot}/com/vaadin/external/gentyref/1.2.0.vaadin1/gentyref-1.2.0.vaadin1.jar"
"${repoRoot}/com/vaadin/vaadin-shared/${1}/vaadin-shared-${1}.jar"
"${repoRoot}/com/vaadin/vaadin-server/${1}/vaadin-server-${1}.jar"
"${repoRoot}/com/vaadin/vaadin-osgi-integration/${1}/vaadin-osgi-integration-${1}.jar"
"${repoRoot}/com/vaadin/vaadin-client-compiled/${1}/vaadin-client-compiled-${1}.jar"
"${repoRoot}/com/vaadin/vaadin-themes/${1}/vaadin-themes-${1}.jar"
"${repoRoot}/com/vaadin/vaadin-liferay-integration/${1}/vaadin-liferay-integration-${1}.jar"
)