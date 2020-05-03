#!/bin/bash
status="$(curl -Is --write-out %{http_code}  --silent --output /dev/null $NEXUS_MAVEN_PUBLIC_URL --connect-timeout 1 | head -1)"

code=${2:-401}
echo $status
if [[ $status == ${code} ]]
then 

echo "401-unsuccessful"
else 
echo "modifying"
export export_setting="dfd"
set export_setting="dfd"

fi


