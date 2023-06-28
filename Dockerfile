FROM maven:3.8.6-openjdk-18-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
WORKDIR /home/app
RUN mvn install -DskipTests

FROM openjdk:20
COPY --from=build /home/app/target/*.jar /usr/local/lib/my-app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/local/lib/my-app.jar"]