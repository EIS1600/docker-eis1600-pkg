# Docker of our eis1600-pkg

This repo contains the `Dockerfile` from which the image was created.

## Prerequisits

* Install docker
* Create 'EIS1600/' with folder structure:

```
|---| EIS1600_Pretrained_Models (`sync from Nextcloud)
|---| OpenITI_EIS1600_Texts
|---| Training_Data
```

## Run docker

Edit the path in angle brakets to the absolute path of the EIS1600 directory on your system.

```shell
docker run -it -v "</path/to/EIS1600>:/EIS1600" eis1600-pkg
```

## Build docker image

```shell
docker build -t eis1600-pkg .
```
