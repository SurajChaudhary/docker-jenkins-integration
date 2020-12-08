FROM openjdk:8
ADD target/my-app.jar my-app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/my-app.jar"]