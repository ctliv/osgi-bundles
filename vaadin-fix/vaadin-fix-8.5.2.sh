#!/bin/bash

basedir=$(dirname "$0")

declare -a resources=(
"https://repo1.maven.org/maven2/org/jsoup/jsoup/1.11.0/jsoup-1.11.0.jar"
"https://repo1.maven.org/maven2/com/vaadin/external/gentyref/1.2.0.vaadin1/gentyref-1.2.0.vaadin1.jar"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-shared/8.5.2/vaadin-shared-8.5.2.jar"
"${basedir}/../vaadin-server-fix/find.sh 8.5.2"
"${basedir}/../vaadin-osgi-integration-fix/find.sh 8.5.2"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-client-compiled/8.5.2/vaadin-client-compiled-8.5.2.jar"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-themes/8.5.2/vaadin-themes-8.5.2.jar"
"${basedir}/../vaadin-liferay-integration-fix/target/find.sh 8.5.2"
)
