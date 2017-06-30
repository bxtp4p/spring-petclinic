# Dockerized Spring PetClinic Sample Application

The purpose of this project was to take an existing application and make it run on Docker. 

## Building and running the application with Docker Compose
Run the following:

```
	git clone https://github.com/bxtp4p/spring-petclinic.git
	cd spring-petclinic
	docker-compose build
	docker-compose up -d
```
You can now access the Dockerized app at: [http://localhost](http://localhost)

## Running petclinic using Docker Swarm
Make sure you are running in swarm mode (`docker swarm init`). You can then run the following to deploy the containers to Docker Swarm with:

```
	docker stack deploy -c docker-compose.yml spring-petclinic
```