# Stage 1: Build the Java project with Maven
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the built JAR
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Render will set the PORT automatically
ENV PORT=8080
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
