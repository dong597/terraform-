terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.13.1"
        }
    }
}

provider "aws" {
    region = "ap-northeast-1"
}