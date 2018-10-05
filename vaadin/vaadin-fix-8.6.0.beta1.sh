#!/bin/bash

basedir=$(dirname "$0")

mvnRoot="https://repo1.maven.org/maven2"
repoRoot="http://maven.vaadin.com/vaadin-prereleases"
version="8.6.0.beta1"

declare -a resources=(
"${mvnRoot}/org/jsoup/jsoup/1.11.2/jsoup-1.11.2.jar"
"${mvnRoot}/com/vaadin/external/gentyref/1.2.0.vaadin1/gentyref-1.2.0.vaadin1.jar"
"${repoRoot}/com/vaadin/vaadin-shared/${version}/vaadin-shared-${version}.jar"
"${basedir}/../vaadin-server-fix/get.sh ${version}"
"${repoRoot}/com/vaadin/vaadin-osgi-integration/${version}/vaadin-osgi-integration-${version}.jar"
"${repoRoot}/com/vaadin/vaadin-client-compiled/${version}/vaadin-client-compiled-${version}.jar"
"${repoRoot}/com/vaadin/vaadin-themes/${version}/vaadin-themes-${version}.jar"
"${repoRoot}/com/vaadin/vaadin-liferay-integration/${version}/vaadin-liferay-integration-${version}.jar"
)

