# Stage 1: Build the application
# Use an official Maven image to build the Java application
# Adjusted the tag to a more general one that includes JDK 8

FROM maven:3.6-jdk-8 AS builder

# Set the working directory inside the container for building
WORKDIR /app

# Copy the Java application source code into the container
COPY . .

# Build the Java application into a JAR file
RUN mvn clean package -DskipTests=true

# Stage 2: Create the runtime image
# Use an official OpenJDK image as the runtime image
FROM openjdk:8u151-jdk-alpine3.7

# Expose the port the app runs on
EXPOSE 8070

# Set the environment variable for the application home
WORKDIR /usr/src/app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/shopping-cart-0.0.1-SNAPSHOT.jar app.jar

# Define the command to run the Java application
ENTRYPOINT exec java -jar app.jar
