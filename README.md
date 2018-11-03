# broadinstitute/docker-terraform
[![](https://images.microbadger.com/badges/image/broadinstitute/terraform.svg)](http://microbadger.com/images/broadinstitute/terraform "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/broadinstitute/terraform.svg)](https://hub.docker.com/r/broadinstitute/terraform/)
[![Docker Hub](http://img.shields.io/docker/pulls/broadinstitute/terraform.svg)](https://hub.docker.com/r/broadinstitute/terraform/)

## What is terraform

[Terraform][1] provides a common configuration to launch infrastructure from physical and virtual servers to email and DNS providers. Once launched, [Terraform][1] safely and efficiently changes infrastructure as the configuration is evolved.

Simple file based configuration gives you a single view of your entire infrastructure.

http://www.terraform.io/

## Dockerfile

This Docker image is based on the official [Alpine][2] 3.8 base image.

## Terraform configuration files

This container expects the user to mount in a directory, which will be mapped to the `/data` directory inside the container.  This is the directory from which [Terraform][1] is configured to read the configuration files referenced by the commands you call.

## How to run this image

For most terraform commands, the run command is as simple as:

```
docker run -it --rm broadinstitute/terraform [--version] [--help] <command> [<args>]
```

Some, however, require higher network privileges and SSL certificates to function correctly, which need to be mapped into the `/etc/ssl/certs` directory in the container, similar to:

```
docker run -it --rm -v /etc/ssl/certs:/etc/ssl/certs:ro --net=host broadinstitute/terraform [--version] [--help] <command> [<args>]
```

therefore, the repository used to build this container also contains a usefull `terraform.sh` script that will handle most of this, so that the commands can be much shorter.  All that is required is filling in a `config.sh` script, so that the script will know where the `/data` directory is located, as well as the path to the SSL certificates.  The script will then determine whether each individual run requires the certificates, as well as things like `sudo`, etc.  Therefore, for the commands below, you could substitute the `terraform.sh` script for everything but the command and options.  For example, if you have the `config.sh` correctly configured, you could do the following to run the **apply** command:

```
./terraform.sh apply [options]
```

### terraform apply

```
docker run -it --rm -v /data:/data -v /etc/ssl/certs:/etc/ssl/certs:ro --net=host broadinstitute/terraform apply [options]
```

### terraform destroy

```
docker run -it --rm -v /data:/data broadinstitute/terraform destroy [options] [DIR]
```

### terraform get

```
docker run -it --rm -v /data:/data broadinstitute/terraform get [options] PATH
```

### terraform graph

```
docker run -it --rm -v /data:/data broadinstitute/terraform graph [options]
```

### terraform init

```
docker run -it --rm -v /data:/data broadinstitute/terraform init [options] SOURCE [PATH]
```

### terraform output

```
docker run -it --rm -v /data:/data broadinstitute/terraform output [options] NAME
```

### terraform plan

```
docker run -it --rm -v /data:/data -v /etc/ssl/certs:/etc/ssl/certs:ro --net=host broadinstitute/terraform plan [options]
```

### terraform push

```
docker run -it --rm -v /data:/data -v /etc/ssl/certs:/etc/ssl/certs:ro --net=host broadinstitute/terraform push [options]
```

### terraform refresh

```
docker run -it --rm -v /data:/data -v /etc/ssl/certs:/etc/ssl/certs:ro --net=host broadinstitute/terraform refresh [options]
```

### terraform remote

```
docker run -it --rm -v /data:/data -v /etc/ssl/certs:/etc/ssl/certs:ro --net=host broadinstitute/terraform remote [options]
```

### terraform show

```
docker run -it --rm -v /data:/data broadinstitute/terraform show terraform.tfstate [options]
```

### terraform taint

```
docker run -it --rm -v /data:/data -v /etc/ssl/certs:/etc/ssl/certs:ro --net=host broadinstitute/terraform taint [options] name
```

### terraform version

```
docker run -it --rm broadinstitute/terraform version
```

[1]: http://www.terraform.io/ "Terraform"
[2]: https://registry.hub.docker.com/_/alpine "Alpine"
