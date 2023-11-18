# syntax = docker/dockerfile:experimental
FROM registry.cn-hangzhou.aliyuncs.com/test-lzy/maven:3.8.1-openjdk-17-slim as build
WORKDIR .
COPY pom.xml .
#RUN mvn dependency:go-offline -B
COPY settings.xml /root/.m2/settings.xml
COPY src src
RUN mvn package -DskipTests
FROM registry.cn-hangzhou.aliyuncs.com/test-lzy/openjdk:17
WORKDIR .

COPY --from=build ./target/*.jar ./app.jar
EXPOSE 8181
CMD ["java","-jar","app.jar"]
