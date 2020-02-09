
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
ARG DOCKER_CONFIG
RUN echo ${DOCKER_CONFIG}
ADD settings.xml /root/.m2/settings.xml
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package




FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/tektoncd-spring-boot-0.0.1-SNAPSHOT.jar /usr/local/lib/tektoncd-spring-boot.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/tektoncd-spring-boot.jar"]
