export DDR_HOST=bxt-ddr.centralus.cloudapp.azure.com:5001
export DOCKER_IMAGE_NAME=$DDR_HOST/bxt.org/spring-petclinic
export DOCKER_IMAGE_NAME_POM=$DOCKER_IMAGE_NAME:$POM_VERSION
export DOCKER_DB_IMAGE_NAME=$DOCKER_IMAGE_NAME-db
export DOCKER_DB_IMAGE_NAME_POM=$DOCKER_DB_IMAGE_NAME:$POM_VERSION
export COMPOSE_FILE=./docker-compose.ucp.yml

#Build using Docker Compose
sudo docker-compose -f $COMPOSE_FILE build

#Create tags for the POM version
docker tag $DOCKER_IMAGE_NAME $DOCKER_IMAGE_NAME_POM
docker tag $DOCKER_DB_IMAGE_NAME $DOCKER_DB_IMAGE_NAME_POM

#Image signing
export DOCKER_CONTENT_TRUST=1
export DOCKER_CONTENT_TRUST_ROOT_PASSPHRASE="$DOCKER_CONTENT_TRUST_DEFAULT_PASSPHRASE"
export DOCKER_CONTENT_TRUST_REPOSITORY_PASSPHRASE="$DOCKER_CONTENT_TRUST_DEFAULT_PASSPHRASE"

#Log in to DTR
docker login https://$DDR_HOST -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

#Push the images to the registry
docker push $DOCKER_IMAGE_NAME:latest
docker push $DOCKER_IMAGE_NAME_POM
docker push $DOCKER_DB_IMAGE_NAME:latest
docker push $DOCKER_DB_IMAGE_NAME_POM

#Log out of DTR
docker logout https://$DDR_HOST

#Deploy to UCP
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH="/ucp/ucp-cli-client"
export DOCKER_HOST=tcp://bxt-ucp.centralus.cloudapp.azure.com:443
docker stack deploy -c $COMPOSE_FILE spring-petclinic
