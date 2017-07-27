## Task

### Docker container that can run [Terraform][1].

### Provision an EC2 instance in AWS that runs an example server.

### The infrastructure must be provisioned from your Infrastructure as Code container running locally

## Dockerfile

This Docker image is based on the official [Alpine][2] 3.6 base image and it installs [Terraform][1] 0.9.11.

## How to run this task

### Create your own config.sh from the config.sample.sh

### ./terraform.sh init

### ./terraform.sh plan --out new_plan

### ./terraform.sh apply new_plan

### ./terraform.sh output public_dns

### Wait 2 or 3 min and you can curl the public_dns output or open in the browser.  

### ./terraform.sh destroy

[1]: http://www.terraform.io/ "Terraform"
[2]: https://registry.hub.docker.com/_/alpine "Alpine"
