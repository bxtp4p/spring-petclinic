# Dockerized Spring PetClinic Sample Application
## Build status

[![Build Status](http://bxt-bld0.centralus.cloudapp.azure.com:8080/buildStatus/icon?job=spring-petclinic)]

(if the image is missing, it's because the build server is off)

## Building the application
Run the following:

```
	git clone https://github.com/bxtp4p/spring-petclinic.git
	cd spring-petclinic
	./build.sh
```

This build script copies the source files to the build image, create an intermediate container to execute the build (and generate the WAR file), then copies the generated WAR to the web server (Tomcat) image.

## Running petclinic with Docker Compose
Assuming the build succeeded, you can then run the following to start the containers (web and db services) with Docker Compose:

```
	docker-compose up -d
```

You can now access the Dockerized app at: [http://localhost:8080/](http://localhost:8080)

## Running petclinic using Docker Swarm
Make sure you are running in swarm mode (`docker swarm init`). You can then run the following to deploy the containers to Docker Swarm with:

```
	docker stack deploy -c docker-compose.yml spring-petclinic
```

You can now access the Dockerized app at: [http://localhost:8080/](http://localhost:8080)
## Running petclinic locally
```
	git clone https://github.com/bxtp4p/spring-petclinic.git
	cd spring-petclinic
	./mvnw spring-boot:run
```

You can then access petclinic here: http://localhost:8080/

<img width="1042" alt="petclinic-screenshot" src="https://cloud.githubusercontent.com/assets/838318/19727082/2aee6d6c-9b8e-11e6-81fe-e889a5ddfded.png">

## Understanding the Spring Petclinic application with a few diagrams
<a href="https://speakerdeck.com/michaelisvy/spring-petclinic-sample-application">See the presentation here</a>

## Working with Petclinic in Eclipse/STS

### prerequisites
The following items should be installed in your system:
* Maven 3 (http://www.sonatype.com/books/mvnref-book/reference/installation.html)
* git command line tool (https://help.github.com/articles/set-up-git)
* Eclipse with the m2e plugin (m2e is installed by default when using the STS (http://www.springsource.org/sts) distribution of Eclipse)

Note: when m2e is available, there is an m2 icon in Help -> About dialog.
If m2e is not there, just follow the install process here: http://eclipse.org/m2e/download/


### Steps:

1) In the command line
```
git clone https://github.com/bxtp4p/spring-petclinic.git
```
2) Inside Eclipse
```
File -> Import -> Maven -> Existing Maven project
```
