export DOCKER_IMAGE_NAME=bxt-ddr.centralus.cloudapp.azure.com:5001/dockerdemoorg/spring-petclinic
export DOCKER_IMAGE_NAME_POM=$DOCKER_IMAGE_NAME:$POM_VERSION
export DOCKER_DB_IMAGE_NAME=$DOCKER_IMAGE_NAME-db
export DOCKER_DB_IMAGE_NAME_POM=$DOCKER_DB_IMAGE_NAME:$POM_VERSION
export COMPOSE_FILE=./docker-compose.ucp.yml

#Build using Docker Compose
sudo docker-compose -f $COMPOSE_FILE build

#Create tags for the POM version
sudo docker tag $DOCKER_IMAGE_NAME $DOCKER_IMAGE_NAME_POM
sudo docker tag $DOCKER_DB_IMAGE_NAME $DOCKER_DB_IMAGE_NAME_POM

#Log in to DTR
sudo docker login https://bxt-ddr.centralus.cloudapp.azure.com:5001 -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

#Push the images to the registry
sudo docker push $DOCKER_IMAGE_NAME
sudo docker push $DOCKER_IMAGE_NAME_POM
sudo docker push $DOCKER_DB_IMAGE_NAME
sudo docker push $DOCKER_DB_IMAGE_NAME_POM

#Log out of DTR
sudo docker logout https://bxt-ddr.centralus.cloudapp.azure.com:5001

#Deploy to UCP
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH="/ucp/ucp-cli-client"
export DOCKER_HOST=tcp://bxt-ucp.centralus.cloudapp.azure.com:443
docker stack deploy -c $COMPOSE_FILE spring-petclinic
