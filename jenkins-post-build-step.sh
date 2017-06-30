export DOCKER_IMAGE_NAME=bxtp4p/spring-petclinic
export DOCKER_IMAGE_NAME_POM=$DOCKER_IMAGE_NAME:$POM_VERSION
export DOCKER_DB_IMAGE_NAME=$DOCKER_IMAGE_NAME-db
export DOCKER_DB_IMAGE_NAME_POM=$DOCKER_DB_IMAGE_NAME:$POM_VERSION

#Log in to Docker
sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

#Build using Docker Compose
sudo docker-compose build

#Create tags for the POM version
sudo docker tag $DOCKER_IMAGE_NAME $DOCKER_IMAGE_NAME_POM
sudo docker tag $DOCKER_DB_IMAGE_NAME $DOCKER_DB_IMAGE_NAME_POM

#Push the images to the registry
sudo docker push $DOCKER_IMAGE_NAME
sudo docker push $DOCKER_IMAGE_NAME_POM
sudo docker push $DOCKER_DB_IMAGE_NAME
sudo docker push $DOCKER_DB_IMAGE_NAME_POM

#Use Docker Compose to deploy services to the cluster
export DOCKER_HOST=tcp://127.0.0.1:32768
docker stack deploy -c ./docker-compose.yml spring-petclinic
DOCKER_HOST=

#Log out of Docker
sudo docker logout