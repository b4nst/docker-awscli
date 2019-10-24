# docker-awscli

[![Github Action](https://github.com/b4nst/docker-awscli/workflows/deploy/badge.svg)](https://github.com/b4nst/docker-awscli/actions?workflow=deploy)
![Docker Pulls](https://img.shields.io/docker/pulls/banst/awscli.svg?label=pulls&logo=docker)
![MicroBadger Size](https://img.shields.io/microbadger/image-size/banst/awscli.svg)

awscli in a container

```shell
docker run --rm -it banst/awscli --version
```

This image is [automatically builded](https://github.com/BastienAr/docker-awscli/actions) to catch up with all official releases available for the aws-cli.

As this image is mainly useful in a CI context, [jq](https://stedolan.github.io/jq/) is also provided in it, to parse some awscli response.

```shell
aws apigateway get-rest-apis | jq -r '.items[]|select(.name == "my-api")|.id'
```
