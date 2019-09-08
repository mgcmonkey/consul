#!/bin/sh

# -----------------------------------------------------------------------------
#
# Environment Variable Prerequisites
#
#   JAVA_HOME       Must point at your Java Development Kit installation.
#                   Required to run the with the "debug" argument.
# -----------------------------------------------------------------------------

# resolve links - $0 may be a softlink

if [ -z "$EXECUTABLEJAR" ]; then
  echo "executable is empty "
  exit 1
fi

if [ ! -r "$EXECUTABLEJAR" ]; then
  echo "EXECUTABLEJAR can not find "
  exit 1
fi

PRG="$EXECUTABLEJAR"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# Get standard environment variables
PRGDIR=`dirname "$PRG"`

JAVA_OPTS="$JAVA_OPTS"

# Register custom URL handlers
#JAVA_OPTS="$JAVA_OPTS -Djava.protocol.handler.pkgs=org.apache.catalina.webresources"

# ----- Execute The Requested Command ----------------------------------------
if [ ! -z "$JAVA_HOME" ] ; then
   JAVA_HOME="$JAVA_HOME"
   if [[ $JAVA_HOME == */ ]]; then
     RUNJAVA="$JAVA_HOME""bin/java"
   else
     RUNJAVA="$JAVA_HOME""/bin/java"
   fi
else
   RUNJAVA="java"
fi

_runcommand="$RUNJAVA $JAVA_OPTS -jar $PRGDIR/${EXECUTABLEJAR##*/}"

echo "command:" $_runcommand

exec $_runcommand

