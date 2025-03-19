#build war file
FROM maven:3.8-openjdk-8-slim as warbuild
WORKDIR /app
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package


#this is to trigger jenkins
#Deploying into tomcat
FROM tomcat:jre8-alpine
COPY --from=warbuild /app/target/WebAppCal-0.0.5.war /usr/local/tomcat/webapps/webappcal.war

