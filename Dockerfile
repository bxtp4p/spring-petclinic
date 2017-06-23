FROM tomcat:latest

# Remove the root folder
RUN rm -r /usr/local/tomcat/webapps/ROOT

# Add the application archive as ROOT.war so that the app becomes the root 
ADD target/spring-petclinic-1.5.1.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080