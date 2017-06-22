FROM tomcat:latest

# Add the application archive 
ADD target/spring-petclinic-1.5.1.war /usr/local/tomcat/webapps/pet-clinic.war

# Expose port 8080
EXPOSE 8080