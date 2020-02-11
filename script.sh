#!/bin/bash
sed -i 's=${NEXUS_PUBLIC_URL}='"$NEXUS_PUBLIC_URL"'=g'  settings.xml
sed -i 's=${NEXUS_USER}='"$NEXUS_USER"'=g'  settings.xml
sed -i 's=${NEXUS_PASSWORD}='"$NEXUS_PASSWORD"'=g'  settings.xml

