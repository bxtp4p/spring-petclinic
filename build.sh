#!/bin/bash
set -e

# create the build image
echo Building Build Image: bxtp4p/spring-petclinic:build
docker build . -t bxtp4p/spring-petclinic:build -f Dockerfile.build

# create intermediate build container if it doesn't exist
buildcontainer="$(docker ps -a | grep "spring-petclinic-build" | awk '{print $1}')"

if [[ -z "$buildcontainer" ]]
then
	echo Creating build container: spring-petclinic-build
	docker create --name spring-petclinic-build bxtp4p/spring-petclinic:build
fi

# extract the war from the build container
docker cp spring-petclinic-build:/code/target/spring-petclinic.war ./target/spring-petclinic.war

# build the app image
echo Building App Image: bxtp4p/spring-petclinic
docker build -t bxtp4p/spring-petclinic .

echo Building App Image Completed: bxtp4p/spring-petclinic
echo Run: docker run -d -p 8080:8080 bxtp4p/spring-petclinic
echo Accessible at http://localhost:8080