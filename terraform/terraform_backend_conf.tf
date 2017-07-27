terraform {
  backend "s3" {
    bucket  = "felipe-test"
    key     = "task/task-terraform.tfstate"
    region  = "eu-west-1"
    profile = "default"
    encrypt = "1"
  }
}
