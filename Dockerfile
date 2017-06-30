FROM java:8

# Install wget
RUN apt-get install -y wget

# Install maven
RUN apt-get update

# get maven 3.2.2
RUN wget --no-verbose -O /tmp/apache-maven-3.2.2.tar.gz http://archive.apache.org/dist/maven/maven-3/3.2.2/binaries/apache-maven-3.2.2-bin.tar.gz

# install maven
RUN tar xzf /tmp/apache-maven-3.2.2.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.2.2 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.2.2.tar.gz
ENV MAVEN_HOME /opt/maven

# remove download archive files
RUN apt-get clean

WORKDIR /code

# Copy the maven file to the app directory
COPY pom.xml .

# Copy the source
COPY src ./src

# Copy the source files and execute the build to generate the WAR
RUN ["mvn", "clean", "package", "-DskipTests"]

FROM tomcat:9
# Install some dependencies
# Netcat used by wait-for-db script
RUN apt-get update; apt-get install zip netcat -y

# This script forces a wait to make sure the DB is ready
COPY ./wait-for-db.sh .
RUN ["chmod", "+rx", "./wait-for-db.sh"]

### Deploy the WAR to Tomcat
# Remove the root folder
RUN ["rm", "-r", "/usr/local/tomcat/webapps/ROOT"]
# Copy the application archive as ROOT.war so that the app becomes the root 
COPY ./target/spring-petclinic.war /usr/local/tomcat/webapps/ROOT.war

HEALTHCHECK --interval=60s --timeout=30s --retries=5 CMD curl -f localhost:8080 || exit 1
 
# Expose port 8080
EXPOSE 8080

CMD ./wait-for-db.sh && /usr/local/tomcat/bin/catalina.sh run