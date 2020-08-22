#!/bin/bash

# start from zero IMPORTANT remove all other docker images
# docker stop $(docker ps -aq); docker rm $(docker ps -aq); docker rmi $(docker images -q);
# docker system prune

docker kill icecast
docker rm -f icecast
docker rmi -f cakebread/gigcaster-icecast
time docker-compose -f docker-compose-build.yml build

# log into docker container
# docker exec -it rolla-icecast-kh bash
