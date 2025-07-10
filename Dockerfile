FROM openjdk:11-jre-slim
WORKDIR /app
COPY target/aml-microservice-1.0-SNAPSHOT.jar /app/aml-microservice.jar
EXPOSE 8080
CMD ["java", "-jar", "aml-microservice.jar"]