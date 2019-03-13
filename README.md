# ros-docker-systemd
Setting up ROS tutorials repository with Docker as a service

```bash
docker build -t ros_tutorials .
```

Start a docker container running the ROS node as:
```bash
docker run --rm --network="host" --name ros_node -it ros_tutorials:latest
```
This starts the docker container on the same network bridge as the docker host hence there is no requirement to setup `ROS_MASTER_URI` and `ROS_HOSTNAME` in the docker container.
