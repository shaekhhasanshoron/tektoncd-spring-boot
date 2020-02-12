#!/bin/bash
sed -i 's=</project>=<distributionManagement><repository><id>nexus</id><name>Releases</name><url>'"$NEXUS_MAVEN_RELEASES_URL"'</url></repository><snapshotRepository><id>nexus</id><name>Snapshot</name><url>'"$NEXUS_MAVEN_SNAPSHOTS_URL"'</url></snapshotRepository></distributionManagement> </project>=g'  pom.xml

