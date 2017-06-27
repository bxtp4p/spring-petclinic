FROM tomcat

# Remove the root folder
RUN rm -r /usr/local/tomcat/webapps/ROOT

# Copy the application archive as ROOT.war so that the app becomes the root 
COPY ./target/spring-petclinic.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080