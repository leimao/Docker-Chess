# Docker-Chess

Docker Chess is a containerized application for [Scid vs. PC](http://scidvspc.sourceforge.net/).

## Usages

### Build Docker Image

To build the Docker container, please run the following command in the terminal.

```bash
$ docker build -f docker/chess.Dockerfile --no-cache --tag=chess:0.0.4 .
```

### Run Docker Container

To execute Scid vs. PC from the Docker container, please run the following command in the terminal.

```bash
$ xhost +
$ docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix chess:0.0.4
$ xhost -
```

### Mount Chess Database

We could also mount the external chess database to the Docker container and load it in Scid vs. PC. For example, to mount the [Caïssabase](http://caissabase.co.uk/) to the Docker container, please run the following command in the terminal.

```
$ mkdir -p /tmp/caissabase/
$ cd /tmp/caissabase/
$ wget http://caissabase.co.uk/downloads/Caissabase_2020_11_14.zip && \
$ unzip Caissabase_2020_11_14.zip
$ rm Caissabase_2020_11_14.zip
$ xhost +
$ docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp/caissabase/:/mnt/database chess:0.0.4
$ xhost -
```

