#!/bin/bash

export JAVA_OPTS='--add-opens java.base/java.net=ALL-UNNAMED --add-opens java.base/java.lang.invoke=ALL-UNNAMED'

java $JAVA_OPTS -jar gerrit.war init --batch --install-all-plugins -d install
java $JAVA_OPTS -jar gerrit.war reindex -d install
