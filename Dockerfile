
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
ARG nexususer
ARG nexuspassword
ARG nexus-public-url
ARG nexus-releases-url
ARG nexus-snapshots-url

ENV nexususer $nexususer
ENV nexuspassword $nexuspassword
ENV nexus-public-url $nexus-public-url
ENV nexus-releases-url $nexus-releases-url
ENV nexus-snapshots-url $nexus-snapshots-url


RUN export nexususer
RUN export nexuspassword
RUN export nexus-public-url
RUN export nexus-releases-url
RUN export nexus-snapshots-url

RUN printenv
ADD settings.xml /root/.m2/settings.xml
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package




FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/tektoncd-spring-boot-0.0.1-SNAPSHOT.jar /usr/local/lib/tektoncd-spring-boot.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/tektoncd-spring-boot.jar"]
