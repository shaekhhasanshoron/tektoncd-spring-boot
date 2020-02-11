
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
ARG NEXUS_USER
ARG NEXUS_PASSWORD
ARG NEXUS_PUBLIC_URL
ARG NEXUS_RELEASES_URL
ARG NEXUS_SNAPSHOTS_URL

ENV NEXUS_USER $NEXUS_USER
ENV NEXUS_PASSWORD $NEXUS_PASSWORD
ENV NEXUS_PUBLIC_URL $NEXUS_PUBLIC_URL
ENV NEXUS_RELEASES_URL $NEXUS_RELEASES_URL
ENV NEXUS_SNAPSHOTS_URL $NEXUS_SNAPSHOTS_URL


RUN export NEXUS_USER
RUN export NEXUS_PASSWORD
RUN export NEXUS_PUBLIC_URL
RUN export NEXUS_RELEASES_URL
RUN export NEXUS_SNAPSHOTS_URL
ADD script.sh .
ADD settings.xml .

RUN /script.sh
COPY settings.xml settings.xml
CMD cat settings.txt

RUN printenv
ADD settings.xml /root/.m2/settings.xml
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package




FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/tektoncd-spring-boot-0.0.1-SNAPSHOT.jar /usr/local/lib/tektoncd-spring-boot.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/tektoncd-spring-boot.jar"]
