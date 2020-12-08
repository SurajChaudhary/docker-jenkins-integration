#!/bin/bash
ENVIRONMENT=$1
QA="QA"
SQA="SQA"
LOG_LEVEL="info"

mvn clean install -Dmaven.test.skip=true
docker build -t chaudharysurajsingh/my-app .

if [ "$ENVIRONMENT" == "$QA" ]
then
echo "Executing docker for $QA environment";
docker run -i -t -p 8080:8080 -p 8000:8000 -e CATALINA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -Duser.timezone='+05:30'" --name my-app chaudharysurajsingh/my-app /bin/sh
elif [ "$ENVIRONMENT" == "$SQA" ]
then
echo "Executing docker for $SQA environment";
docker run -i -t -p 9090:8080 -p 8000:8000 -e CATALINA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -Duser.timezone='+05:30'" -e HOST='pulsar.sqaextranet.akamai.com' -e HOST_PORT='443' -e HOST_SCHEME='https' -e SERVICE_ENVIRONMENT="qa" -e PULSAR_LOG_LEVEL="$LOG_LEVEL" -v $PWD/docker-config/secrets/:/secrets:ro pulsar/akamai-marketplace /bin/bash
elif [ -z "$ENVIRONMENT" ]
then
echo "Executing docker for $SQA environment[default]";
docker run -i -t -p 9090:8080 -e HOST='iamakamai.sqaextranet.akamai.com' -e SERVICE_ENVIRONMENT='qa' -e PULSAR_CLIENT_APPLICATION_NAME='akamai-marketplace' -e HOST_PORT='443' -e HOST_SCHEME='https' -e PULSAR_LOG_LEVEL="$LOG_LEVEL" -v $PWD/docker-config/secrets/:/secrets:ro pulsar/akamai-marketplace /bin/bash
else
echo "Unable to find system. Allowed syntax './run.sh $QA' or './run.sh $SQA'";
exit
fi