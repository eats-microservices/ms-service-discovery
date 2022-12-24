FROM maven:3.8.6-amazoncorretto-17 AS builder
COPY /src /usr/src/app/src
COPY /pom.xml /usr/src/app
RUN mvn -DskipTests -f /usr/src/app/pom.xml clean package

FROM openjdk:17
COPY --from=builder /usr/src/app/target/*.jar /usr/app/app.jar
EXPOSE 8761
ENTRYPOINT ["java","-jar","/usr/app/app.jar"]