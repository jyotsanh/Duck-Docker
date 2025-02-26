```FROM
WORK
COPY
RUN
EXPOSE
CMD
```

## command to remember for a docker:
- ```bash docker build -t myapi .```
    - docker build command to build a docker image
    - `-t` allows you to tag a name in the image
    - `myFastAPI` name of the Docker image
    -  `.` docker will look for Dockerfile in current directory.

- ``docker run -d -p 8000:8002 myapi``
    - `docker build` : command to build a docker image
    - ``-d`` detached mode, means run in the background
    - `-p 8000:8002`: maps port 8000 of your host machine to port 8002 of the container.
        - -p [host_port]:[container_port]
    - `myapi` image tag name

- docker ps -a
    - all running or exited image in docker 
- docker ps
    - all running images in docker
    
- docker logs "6691dc4e2c3f"
    - checks logs of image with container id "6691dc4e2c3f"

- docker stop [CONTAINER_ID]
    - stops a docker container
- docker start [CONTAINER_ID]
    - start a docker container
- docker rm [CONTAINER_ID]
    - removes the container
- docker stats
    - shows real time resource usage of all running containers

- docker images
    - shows the docker images in system
- docker rmi [IMAGE_ID]
    - deletes the images

# Steps:
1.Create a Dockerfile:
2.build a docker image using command "sudo docker build -t [docker image name] ."
3.run the docker image using command "sudo docker run -d --name [docker container name] -p 8002:8002 [docker image name]"
4.see the docker runnig image using command "sudo docker ps -a"