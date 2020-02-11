
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
ARG nexususer
ARG nexuspassword
ARG nexus-public-url
ARG nexus-releases-url
ARG nexus-snapshots-url

ENV NEXUS_USER $nexususer
ENV NEXUS_PASSWORD $nexuspassword
ENV NEXUS_PUBLIC_URL $nexus-public-url
ENV NEXUS_RELEASES_URL $nexus-releases-url
ENV NEXUS_SNAPSHOTS_URL $nexus-snapshots-url


RUN export NEXUS_USER
RUN export NEXUS_PASSWORD
RUN export NEXUS_PUBLIC_URL
RUN export NEXUS_RELEASES_URL
RUN export NEXUS_SNAPSHOTS_URL
ADD script.sh .
RUN ls
RUN /script.sh
CMD cat settings.txt

RUN printenv
ADD settings.xml /root/.m2/settings.xml
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package




FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/tektoncd-spring-boot-0.0.1-SNAPSHOT.jar /usr/local/lib/tektoncd-spring-boot.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/tektoncd-spring-boot.jar"]
