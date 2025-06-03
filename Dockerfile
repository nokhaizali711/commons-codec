# Use Maven to build the project
FROM maven:3.8.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn -Drat.skip=true clean package -DskipTests

# Use a lightweight JRE to run the app
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar commons-codec.jar
CMD ["java", "-jar", "commons-codec.jar"]