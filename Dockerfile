FROM openjdk:8-jdk-alpine
RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*
EXPOSE 8080
WORKDIR /app
COPY target/tektoncd-spring-boot.jar .
ENTRYPOINT [ "java", "-jar", "tektoncd-spring-boot.jar" ]
