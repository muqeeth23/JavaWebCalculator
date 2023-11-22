#build war file
FROM maven:3.8-openjdk-8-slim as warbuild
WORKDIR /app
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package



#Deploying into tomcat
FROM tomcat:9.0
RUN mv webapps webapps2
RUN cp -r webapps.dist/ webapps

COPY --from=warbuild /app/target/WebAppCal-0.0.4.war /usr/local/tomcat/webapps/webappcal.war

