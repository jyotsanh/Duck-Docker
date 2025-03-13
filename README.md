![meme](./img/docker.png)

# Duck-Docker

some commands i noted down for you know, when i need them 🐳

```
FROM
WORK
COPY
RUN
EXPOSE
CMD
```

## command to remember for a docker:

- ```bash
  docker build -t myapi . 
  ```

  - docker build command to build a docker image
  - `-t` allows you to tag a name in the image
  - `myFastAPI` name of the Docker image
  - `.` docker will look for Dockerfile in current directory.
- ```bash
  docker run -d -p 8002:8002 myapi
  ```

  - `docker build` : command to build a docker image
  - ``-d`` detached mode, means run in the background
  - `-p 8000:8002`: maps port 8000 of your host machine to port 8002 of the container.
    - -p [host_port]:[container_port]
  - `myapi` image tag name
- ```bash
  docker ps -a
  ```

  - all running or exited image in docker
- ```bash
  docker ps
  ```

  - all running images in docker
- ```bash
  docker logs "6691dc4e2c3f"
  ```

  - checks logs of image with container id "6691dc4e2c3f"
- ```bash
  docker stop [CONTAINER_ID] 
  ```

  - stops a docker container
- ```bash
  docker start [CONTAINER_ID]
  ```

  - start a docker container
- ```bash
    docker rm [CONTAINER_ID]
  ```

  - removes the container
- ```bash
  docker stats
  ```

  - shows real time resource usage of all running containers
- ```bash
    docker images
  ```

  - shows the docker images in system
- ```bash
    docker rmi [IMAGE_ID]
  ```

  - deletes the images

# Docker Commands Guide

1. Create a Dockerfile:

   ```
   Dockerfile
   ```
2. Build a docker image:

   ```bash
   sudo docker build -t [docker image name] .
   ```
3. Create a docker container:

   ```bash
   sudo docker run -d --name [docker container name] -p 8002:8002 [docker image name]
   ```
4. View running docker containers:

   ```bash
   sudo docker ps -a
   ```
5. Stop a docker container:

   ```bash
   sudo docker stop [Container_id]
   ```
6. Restart a docker container:

   ```bash
   sudo docker start [Container_id]
   ```
7. Remove a docker container:

   ```bash
   sudo docker rm [Container_id]
   ```
8. List docker images:

   ```bash
   sudo docker images
   ```
9. Remove a docker image:

   ```bash
   sudo docker rmi [Image_id]
   ```

# Now for Docker-Compose:

Ever wonder what we would have to do if, for example, there's this eCommerce project that requires two images?

Frontend (React)
Backend (Express)
Most real-world projects require multiple services to run—API, webhooks, frontend, databases, and more. In such cases, manually running and managing containers for each service can become a hassle. Imagine having to build and start each container separately every single time.

That’s where Docker Compose comes in, my friend! 🚀

With Docker Compose, you can define all your services in a single docker-compose.yaml file and spin them up with just one command. It handles networking, environment variables, and dependencies automatically, making development much smoother.

In the next steps, we’ll see how to set up Docker Compose for our MERN project, ensuring that both the frontend and backend communicate seamlessly, and everything runs in sync. Let’s dive in! 🔥

## Steps to run our project:

- Project Directory Structure:
  ```
  root
  |--- frontend (react)
  |      |---- Dockerfile
  |--- backend (express)
  |      |---- Dockerfile
  |--- docker-compose.yaml

  ```
- Step 1:
  - Create a `DockerFile` in each service in our case frontend and backend.
  - for frontend

    ```
        # use node 22 as base image for our frontend run-time
        FROM node:22
        # set a working a directory name "app" <-- inside this app our project will run
        WORKDIR /app
        # copy all the required dependencies in our working directory
        COPY package.json ./
        # install all the required dependencies
        RUN npm install
        # copy all the src code from frontend directory to our working directory
        COPY . .
        # expose frontend port  
        EXPOSE 5173
        # run command for our frontend , '--host' command to make it accessible outside the container
        RUN ["npm","run","dev","--host"]

    ```
 - for backend

    ```
        # use node 22 as base image for our backend run-time
        FROM node:22
        # set a working a directory name "app" <-- inside this app our project will run
        WORKDIR /app
        # copy all the required dependencies in our working directory
        COPY package.json ./
        # install all the required dependencies
        RUN npm install
        # copy all the src code from backend directory to our working directory
        COPY . .
        # expose backend port  
        EXPOSE 8000
        # run command for our backend , '--host' command to make it accessible outside the container
        RUN ["npm","start"]

    ```
- Step 2:
  - in the root directory create a `docker-compose.yaml` file:
    ```
        services:
            frontend:
            # dir where frontend src code lies
                build: frontend/
            # sets the container name
                container_name: mern-frontend
            # expose the port "host:container"
                ports:
                - "8002:5173"
            # docker makes sure frontend waits for the backend service to be ready before it starts.
                depends_on:
                - backend
            # this mounts the local frontend folder to app working dir in container
                volumes:
                - ./frontend:/app
            # connects the frontend to 'mern-network' both service in the same network
                networks:
                - mern-network
            backend:
            # build where backend src code lies
                build: backend/
            # sets the container name
                container_name: mern-backend
            # expose the port "host:container"  
                ports:
                - "8001:8000"
            # this mounts the local frontend folder to app working dir in container  
                volumes:
                - ./backend:/app
            # connects the backend to 'mern-network' both service in the same network
                networks:
                - mern-network

            # a custom bridge network named mern-network. This allows the services to communicate with each other
        networks:
            mern-network:
                driver: bridge
    ```

- Step 3:
    - and at the root directory of your project run this command:
        - ``sudo docker-compose up --build``
    - if you are building for the first time it may, run the containers by default
    - To run the container from docker-compose : ```sudo docker-compose up```
    - To stop the container from docker-compose: ```sudo docker-compose down```
    - To restart the container fron docker-compose: ```sudo docker-compose restart```
    - To stop a specific service from docker-compose: ```sudo docker-compose stop backend```
    - To re-run the docker-compose with no cache use ```sudo docker-compose build --no-cache```
  -------

![meme2](./img/meme2.webp)
