
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
ARG NEXUS_USER
ARG NEXUS_PASSWORD
ARG NEXUS_MAVEN_PUBLIC_URL
ARG NEXUS_MAVEN_RELEASES_URL
ARG NEXUS_MAVEN_SNAPSHOTS_URL

ENV NEXUS_USER $NEXUS_USER
ENV NEXUS_PASSWORD $NEXUS_PASSWORD
ENV NEXUS_MAVEN_PUBLIC_URL $NEXUS_MAVEN_PUBLIC_URL
ENV NEXUS_MAVEN_RELEASES_URL $NEXUS_MAVEN_RELEASES_URL
ENV NEXUS_MAVEN_SNAPSHOTS_URL $NEXUS_MAVEN_SNAPSHOTS_URL


ADD script_to_set_settingfile.sh .
ADD script_to_set_pomfile.sh .
ADD settings.xml .
ADD pom.xml .
RUN /script_to_set_settingfile.sh
RUN /script_to_set_pomfile.sh
ADD settings.xml /root/.m2/settings.xml

COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/tektoncd-spring-boot-0.0.1-SNAPSHOT.jar /usr/local/lib/tektoncd-spring-boot.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/tektoncd-spring-boot.jar"]
