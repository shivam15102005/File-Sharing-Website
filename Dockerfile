# ===== Stage 1: Build the Java project with Maven =====
FROM maven:3.9.6-eclipse-temurin-21 AS build

# Set working directory inside container
WORKDIR /app

# Copy only pom.xml first (for dependency caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the project files
COPY src ./src

# Build the project (skip tests for faster build)
RUN mvn clean package -DskipTests

# ===== Stage 2: Run the shaded JAR =====
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy only the runnable shaded JAR (fat JAR with dependencies)
COPY --from=build /app/target/p2p-1.0-SNAPSHOT-shaded.jar app.jar

# Render automatically provides PORT, so use it dynamically
ENV PORT=8080
EXPOSE 8080

# Start the server
CMD ["java", "-jar", "app.jar"]
