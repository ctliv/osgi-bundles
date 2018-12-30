#!/bin/bash

basedir=$(dirname "$0")

declare -a resources=(
"https://repo1.maven.org/maven2/org/jsoup/jsoup/1.11.3/jsoup-1.11.3.jar"
"https://repo1.maven.org/maven2/com/vaadin/external/gentyref/1.2.0.vaadin1/gentyref-1.2.0.vaadin1.jar"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-shared/8.6.3/vaadin-shared-8.6.3.jar"
"${basedir}/../vaadin-server-fix/get.sh 8.6.3"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-osgi-integration/8.6.3/vaadin-osgi-integration-8.6.3.jar"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-client-compiled/8.6.3/vaadin-client-compiled-8.6.3.jar"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-themes/8.6.3/vaadin-themes-8.6.3.jar"
"https://repo1.maven.org/maven2/com/vaadin/vaadin-liferay-integration/8.6.3/vaadin-liferay-integration-8.6.3.jar"
)
