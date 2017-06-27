#!/bin/bash
set -e

# create the build image
echo Building Build Image: bxtp4p/spring-petclinic:build
docker build . -t bxtp4p/spring-petclinic:build -f Dockerfile.build

# run the build container (execute build)
echo Running build container
docker run --name spring-petclinic-build bxtp4p/spring-petclinic:build

# copy the war from the build container to the target directory
docker cp spring-petclinic-build:/code/target/spring-petclinic.war ./target/spring-petclinic.war

# stop and remove the build container
docker stop spring-petclinic-build
docker rm spring-petclinic-build

# build the app image
echo Building App Image: bxtp4p/spring-petclinic
docker build -t bxtp4p/spring-petclinic .

echo Building App Image Completed: bxtp4p/spring-petclinic
echo Run: docker run -d -p 8080:8080 bxtp4p/spring-petclinic
echo Accessible at http://localhost:8080