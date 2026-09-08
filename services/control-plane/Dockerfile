FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -B dependency:go-offline
COPY src ./src
RUN mvn -B package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081
# JVM memory tuned down for free-tier hosts like Render's 512MB plan.
# See docs/PROJECT_GUIDE.md, "Deploying on free tiers".
ENTRYPOINT ["java", "-Xmx350m", "-jar", "app.jar"]
