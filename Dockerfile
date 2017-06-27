FROM tomcat

# Remove the root folder
RUN rm -r /usr/local/tomcat/webapps/ROOT

# Copy the application archive as ROOT.war so that the app becomes the root 
COPY ./target/spring-petclinic.war /usr/local/tomcat/webapps/ROOT.war

HEALTHCHECK --interval=60s --timeout=30s --retries=5 CMD curl -f localhost:8080 || exit 1

# Expose port 8080
EXPOSE 8080