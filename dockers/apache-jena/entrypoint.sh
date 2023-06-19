#!/bin/sh

## env | sort
exec "$JAVA_HOME/bin/java" $JAVA_OPTIONS -jar "${FUSEKI_DIR}/${FUSEKI_JAR}" "$@"
